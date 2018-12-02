class Api::Retailers::V1::RegistrationsController < Devise::RegistrationsController

	skip_before_action :verify_authenticity_token, only: [:create]
	before_action :find_employee, only: [:create]

	def create
		ActiveRecord::Base.transaction do
			build_resource(sign_up_params)
			if sign_up_params[:category_ids].present?
				sign_up_params[:category_ids].split(',').each do |category_id|
					resource.retailer_product_categories.new(product_category_id: category_id)
				end
				if resource.save
					@retailer = resource
					if sign_up_params[:photos].present?
						upload_photo_response = upload_photo(@retailer)
					end
					render template: 'api/retailers/v1/registration.json.jbuilder'
				else
					render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: Errors.customize(resource.errors.full_messages).join(',') } }
				end
			else
				render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: "Please add product category!" }}
			end	
		rescue StandardError => ex	
			resource.destroy if resource.present?
			render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: ex.message } }
		end
	end

	private

	  # Notice the name of the method
	  def sign_up_params
	    params.require(:retailer).permit(
	    	:gst_number,
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
	    	:employee_code,
	    	:category_ids,
	    	:photos => [
	    		:photo,
	    		:lat,
	    		:lng
	    	]
	    )
	  end

		def upload_photo(retailer)
			file_path = "retailers/#{retailer.id}/photos"
			files = sign_up_params[:photos]
			files.values.each do |file|
				if file[:photo].present?
					result = FileUpload.new.upload(file_path, file[:photo])
					if String(result[:status]) == String(RESPONSE[:success])
						retailer_photo = retailer.retailer_photos.new(photo_url: result[:file_url])
						retailer_photo.lat = file[:lat]
						retailer_photo.lng = file[:lng]
						retailer_photo.save!
					end
				end	
			end			
		end

		def find_employee
			@employee = Employee.find_by(ecode: sign_up_params[:employee_code])
		end

end
