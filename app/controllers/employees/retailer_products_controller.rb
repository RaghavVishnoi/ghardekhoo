class Employees::RetailerProductsController < Employees::ApplicationController

	layout 'employee'

	def new
		@retailer = Retailer.find_by(access_token: params[:access_token])
		@retailer_product = @retailer.retailer_products.new
	end

	def create
		ActiveRecord::Base.transaction do
			@retailer_product = RetailerProduct.new(retailer_product_params)
			if @retailer_product.save
				retailer_product_photos = retailer_product_params[:product_photos]
				if retailer_product_photos.present?
					retailer_product_photos.each_with_index do |retailer_product_photo, index|
						if UPLOAD_FILE_LIB == 'active_storage'
							upload_photo_result = upload_to_active_storage(retailer_product_photo, @retailer_product)
						elsif UPLOAD_FILE_LIB == 'aws'						
							upload_photo_result = upload_to_aws(retailer_product_photo, index)
						end
						@retailer_product.retailer_product_photos.find_or_create_by(
							retailer_product_id: @retailer_product.id, 
							photo_url: upload_photo_result[:url], 
							attachment_id: upload_photo_result[:attachment_id])
					end
					@redirect_url = current_employee ? '/employees/retailers' : '/'
					flash[:success] = 'Property added successfully.'
					respond_to do |format|
						format.html { redirect_to @redirect_url }
						format.js
					end
				else
					@show_errors = true
					flash[:error] = 'Please choose photos to upload!'
				end
			else
				@show_errors = true
				flash[:error] = Errors.customize(@retailer_product.errors.full_messages).reverse.join('<br>')
			end
		end
	rescue StandardError => ex
		@show_errors = true
		flash[:error] = ex.message
	end

	private
		def retailer_product_params
			params.require(:retailer_product).permit(
		    	:product_name,
		    	:min_price,
		    	:retailer_id,
		    	:product_sub_category_id,
		    	:description,
		    	:unit,
		    	:address,
		    	:city,
		    	:state,
		    	:max_price,
		    	:upload_date,
		    	:product_type_id,
		    	:address,
		    	:product_operation_id,
		    	:product_photos => [],
		    	property_specification_attributes: [
		    		:bedrooms,
		    		:bathrooms,
		    		:balconies,
		    		:furnishing,
		    		:covered_parking,
		    		:open_parking,
		    		:availability_status,
		    		:possession_by_year,
		    		:possession_by_month,
		    		:ownership,
		    		:other_rooms => []
		    	]
		    )
		end

		def upload_to_active_storage(retailer_photo, retailer_product)
			resized_image = MiniMagick::Image.read(retailer_photo)
			resized_image = resized_image.resize "500x500"
			v_filename = retailer_photo.original_filename
			v_content_type = retailer_photo.content_type
			result = retailer_product.photos.attach(io: File.open(resized_image.path), filename:  v_filename, content_type: v_content_type)
			{url: url_for(result.first), attachment_id: result.first&.id}
		rescue StandardError => ex
			flash[:error] = ex.message
			Rails.logger.info "****************** #{ex.backtrace} *******************"
		end

end