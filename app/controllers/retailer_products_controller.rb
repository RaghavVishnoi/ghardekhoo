class RetailerProductsController < ApplicationController

	before_action :find_retailer_product, only: [:upload_photos]

	def upload_photos
		if @retailer_product.present?
			retailer_photos = params[:retailer_photos]
			if retailer_photos.present?
				retailer_photos.each_with_index do |retailer_photo, index|
					if UPLOAD_FILE_LIB == 'active_storage'
						upload_photo_result = upload_to_active_storage(retailer_photo)
					elsif UPLOAD_FILE_LIB == 'aws'						
						upload_photo_result = upload_to_aws(retailer_photo, index)
					end
					@retailer_product.retailer_product_photos.find_or_create_by(
						retailer_product_id: @retailer_product.id, 
						photo_url: upload_photo_result[:url], 
						attachment_id: upload_photo_result[:attachment_id])
				end
				@redirect_url = "/admin/retailer_product/#{@retailer_product.id}"
			else
				flash[:error] = 'Please choose photos to upload!'
			end
		else
			flash[:error] = 'Please choose a product to upload photos!'
		end
	rescue StandardError => ex
		flash[:error] = ex.message
	end

	private
		def find_retailer_product
			@retailer_product = RetailerProduct.find_by(id: params[:id])
		end

		def upload_to_aws(retailer_photo, index)
	  	file_path = "retailers_products/#{@retailer.id}/product_photo_#{index+1}"
      result = FileUpload.new.upload(file_path, retailer_photo)
      if result[:status] == 200
      	{url: result[:file_url]}
      else
      	flash[:error] = result[:message]
      end
	  end

	  def upload_to_active_storage(retailer_photo)
	  	result = @retailer_product.photos.attach(retailer_photo)
	  	{url: url_for(result.first), attachment_id: result.first&.id}
	  rescue StandardError => ex
			flash[:error] = ex.message
	  end

end