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
							upload_photo_result = @retailer_product.upload_to_active_storage(retailer_product_photo)
						elsif UPLOAD_FILE_LIB == 'aws'						
							upload_photo_result = @retailer_product.upload_to_aws(retailer_product_photo, index)
						end
						@retailer_product.retailer_product_photos.find_or_create_by(
							retailer_product_id: @retailer_product.id, 
							photo_url: upload_photo_result[:url], 
							attachment_id: upload_photo_result[:attachment_id])
					end
					@redirect_url = current_employee? ? '/employees/retailers' : "/"
				else
					flash[:error] = 'Please choose photos to upload!'
				end
			else
				@show_errors = true
				flash[:error] = @retailer_product.errors.full_messages.join('<br>')
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
		    	:product_photos
		    )
		end

end