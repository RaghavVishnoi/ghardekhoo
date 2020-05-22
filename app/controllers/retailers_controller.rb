class RetailersController < ApplicationController

	before_action :find_retailer, only: [:upload_photos]
	before_action :set_defaults, only: [:search]

	def new
		@action = request.url.split('/').last
		@account_type = @action == 'advertise' ? 'premium' : 'free'
		@retailer = Retailer.new
	end

	def create
		ActiveRecord::Base.transaction do
			category_id = retailer_params[:category_ids]
			if category_id.present?
				@retailer = Retailer.new(retailer_params)
				if @retailer.save
					@retailer.retailer_product_categories.create(product_category_id: category_id)
					flash[:success] = t('retailers.signup_success')
				else
					@show_errors = true
					flash[:error] = @retailer.errors.full_messages.join('<br>')
				end
			else
				@show_errors = true
				flash[:error] = t('validations.retailer.missing_category')
			end
		end
	rescue StandardError => ex
		@show_errors = true
		flash[:error] = ex.message
	end

	def show
		username = params[:id].downcase
		if username.present? && username != 'not_available'
			@retailer = Retailer.find_by('LOWER(username) = ? AND account_status = ?', username, 1)
			@retailer_review = RetailerReview.new
			if @retailer.blank?
				flash[:error] = t('retailers.missing_username')
				redirect_to '/'
			end
		else
			flash[:error] = t('retailers.missing_username')
			redirect_to request.referrer
		end
	end

	def state_cities
		state_code = CS.get(:in).map{|k,v| k if v==params[:state_name]}.compact.first
		@cities = CS.cities(state_code , :in)
	end

	def set_location
		@location = Geocoder.search("#{params[:retailer_city_name]}, #{params[:retailer_state_name]}").first.coordinates		
	end

	def search
		@default_category = params[:category_id]
		@search_value = params[:search_value]
		@sub_category_id = params[:sub_category_id]
		@retailers = Retailer
		@retailers = @retailers.where(state: params[:state]) if params[:state].present?
		@retailers = @retailers.where(city: params[:city]) if params[:city].present?
		@retailers = @retailers.where('LOWER(first_name) like ? OR LOWER(last_name) like ?', "%#{@search_value.downcase}%", "%#{@search_value.downcase}%") if params[:search_value].present?
		retailers_with_main_filter = @retailers
		if @sub_category_id.blank?
			@retailers = @retailers.joins(:product_categories).where('product_categories.id = ?', @default_category) if @default_category.present? && @retailers.present?
		else
			@retailers = @retailers.joins(:retailer_products).where('retailer_products.product_sub_category_id = ? AND status = ?', @sub_category_id, 1) if @retailers.present?
		end
		@retailers = @retailers.page(params[:page]).per(RETAILERS_PER_PAGE)
		@retailers_count = RetailerProductCategory.joins(:retailer).where('retailers.id IN (?)', retailers_with_main_filter.pluck(:id)).group_by(&:product_category_id)
	rescue StandardError => ex	
		flash[:error] = ex.message[0..300]
	end

	def nearby_retailers
		if params[:city].present? && params[:state].present?
			Retailer.near("#{params[:city]}, #{params[:state]}, IN", RETAILER_NEAR_BY_RADIUS, units: :km, order: 'first_name').where(account_status: 1)
		else
			state = CS.get(:IN).as_json[params[:state]]
			Retailer.near("#{state}, IN", RETAILER_NEAR_BY_RADIUS, units: :km, order: 'first_name').where(account_status: 1)
		end
	end

	def upload
		errors = []
		file = params[:retailer_data]
		spreadsheet = open_spreadsheet(file)
		retailer_information_sheet = spreadsheet.sheet('RetailerInformation')
		retailer_information_sheet.drop(1).each do |retailer_data|
			retailer = Retailer.new(gst_number: retailer_data[0])
			set_retailer_attributes(retailer, retailer_data)
			retailer.save(validate: false)
		end		
		flash[:success] = "Successfully uploaded!"
		create_error_file(errors)
		@redirect_url = admin_retailer_upload_retailers_path
	rescue StandardError => ex
		errors << ["Internal Server", "Retailer", ex.message[0..300]]
		flash[:error] = ex.message
		create_error_file(errors)
		@redirect_url = admin_retailer_upload_retailers_path
	end

	def upload_photos
		if @retailer.present?
			retailer_photos = params[:retailer_photos]
			if retailer_photos.present?
				Array.wrap(retailer_photos).each_with_index do |retailer_photo, index|
					if UPLOAD_FILE_LIB == 'active_storage'
						upload_photo_result = upload_to_active_storage(retailer_photo)
					elsif UPLOAD_FILE_LIB == 'aws'						
						upload_photo_result = upload_to_aws(retailer_photo, index)
					end
					@retailer.retailer_photos.find_or_create_by(
						retailer_id: @retailer.id, 
						photo_url: upload_photo_result[:url],
						attachment_id: upload_photo_result[:attachment_id]
					)
				end
				@redirect_url = "/admin/retailer/#{@retailer.id}"
			else
				flash[:error] = 'Please choose photos to upload!'
			end
		else
			flash[:error] = 'Please choose a retailer to upload photos!'
		end
	end

	private
		def retailer_params
			params.require(:retailer).permit(
		    	:adhaar_number,
		    	:pan_number,
		    	:first_name,
		    	:last_name,
		    	:phone,
		    	:email,
		    	:password,
		    	:password_confirmation,
		    	:address,
		    	:city,
		    	:state,
		    	:country,
		    	:lat,
		    	:lng,
		    	:category_ids,
		    	:account_type
		    )
		end

		def open_spreadsheet(file)
		  case File.extname(file.original_filename)
		  when ".xlsx","xls","csv" then Roo::Excelx.new(file.path)
		  else raise "Unknown file type: #{file.original_filename}"
		  end
		end

		def set_retailer_attributes(retailer, retailer_data)
			category = ProductCategory.find_by('LOWER(name) = ?', retailer_data[7].downcase)
			retailer.adhaar_number = retailer_data[1]
			retailer.pan_number = retailer_data[2]
			retailer.first_name = retailer_data[3]
			retailer.last_name = retailer_data[4]
			retailer.phone = retailer_data[6]
			retailer.email = retailer_data[5]
			retailer.retailer_product_categories.new(product_category_id: category.try(:id))
			retailer.address = retailer_data[9]
			retailer.city = retailer_data[10]
			retailer.state = retailer_data[11]
			retailer.country = retailer_data[12]
			retailer.lat = retailer_data[13]
			retailer.lng = retailer_data[14]
			employee = Employee.find_by(id: retailer_data[15])
			retailer.employee_id = employee.try(:id)
		end

		def set_product_information(product, product_data)
			product.product_name = product_data[1]
			product.active = true
		end

		def create_error_file(errors)
			if errors.present?
				require "csv"
				data = CSV.generate(headers: true) do |csv|
					csv << ["GSTNumber", "EntityName", "ErrorMessage"]
					errors.each do |error|
						csv << error
					end
		    end
		    send_data data, filename: "UploadErrors.csv"
		  end
		end

		def state_list
			@states = CS.states(:in).map{|h| [h[1],h[0]]}
	  end

	  def city_list(state_code)
	  	@cities = CS.cities(state_code , :in)
	  end

	  def find_retailer
	  	@retailer = Retailer.find_by(id: params[:id])
	  end

	  def upload_to_aws(retailer_photo)
	  	file_path = "retailers/#{@retailer.id}/profile_photo_#{index+1}"
      result = FileUpload.new.upload(file_path, retailer_photo)
      if result[:status] == 200
      	{url: result[:file_url]}
      else
      	flash[:error] = result[:message]
      end
	  end

	  def upload_to_active_storage(retailer_photo)
	  	result = @retailer.photos.attach(retailer_photo)
	  	{url: url_for(result.first), attachment_id: result.first&.id}
	  rescue StandardError => ex
			flash[:error] = ex.message
	  end

	  def set_defaults
			@states = State.where(active: true).pluck(:name)
			@cities = []
		end

end