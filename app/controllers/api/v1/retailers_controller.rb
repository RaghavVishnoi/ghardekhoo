class Api::V1::RetailersController < Api::Retailers::ApisController

	def update
		update_category
		if @current_user.update(retailer_params)
			if retailer_params[:photos].present?
				upload_photo_response = upload_photo
			end
			render template: 'api/v1/retailers/update.json.jbuilder'
		else
			render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: @current_user.errors.full_messages } }
		end
	end


	private
		def retailer_params
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
	    	:profile_photo,
	    	:photos => [
	    		:photo,
	    		:lat,
	    		:lng
	    	]
	    )
		 end

		def update_category
			if retailer_params[:category_ids].present?
			 	current_category_ids = @current_user.retailer_product_categories.pluck(:product_category_id)
			 	new_categories = retailer_params[:category_ids].split(',').map(&:to_i)
				deleted_categories = current_category_ids - new_categories
				new_categories = new_categories - current_category_ids	
				@current_user.retailer_product_categories.where(
					product_category_id: deleted_categories
				).destroy_all if deleted_categories.present?
				new_categories.each do |new_category|
					@current_user.retailer_product_categories.new(product_category_id: new_category)
				end
			end
		end

		def upload_photo
			file_path = "retailers/#{@current_user.id}/photos"
			files = retailer_params[:photos]
			files.values.each do |file|
				if file[:photo].present?
					file_path = file_path+"/"+file[:photo].original_filename
					result = FileUpload.new.upload(file_path, file[:photo])
					if String(result[:status]) == String(RESPONSE[:success])
						retailer_photo = @current_user.retailer_photos.new(photo_url: result[:file_url])
						retailer_photo.lat = file[:lat]
						retailer_photo.lng = file[:lng]
						retailer_photo.save!
					end
				end	
			end			
		end

		def  upload_profile_photo
	    if retailer_params[:profile_photo].present?
	      file_path = "retailers/#{@current_user.id}/profile_photo"
	      result = FileUpload.new.upload(file_path, retailer_params[:profile_photo])
	      if String(result[:status]) == String(RESPONSE[:success])
	        @current_user.update_attribute('photo_url', result[:file_url])
	      end
	    end  
	  end

end