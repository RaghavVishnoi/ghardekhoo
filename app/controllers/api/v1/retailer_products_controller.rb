class Api::V1::RetailerProductsController < Api::Retailers::ApisController

	def index
		@retailer_products = RetailerProduct.where(retailer_id: current_user.id).page(params[:page]).per(PRODUCTS_PER_PAGE)
		render template: 'api/v1/retailer_products/index.json.jbuilder'
	end

	def show
		@retailer_product = RetailerProduct.find_by(id: params[:id])
		render template: 'api/v1/retailer_products/show.json.jbuilder'
	end	

	def create
		@retailer_product = RetailerProduct.find_by(sku_code: product_params[:sku_code], retailer_id: current_user.id)
		if @retailer_product.present? && product_params[:sku_code].present?
			@retailer_product.update(product_params)
			upload_photos(@retailer_product)
			render template: 'api/v1/retailer_products/create.json.jbuilder'
		else
			@retailer_product = RetailerProduct.new(product_params.merge(retailer_id: current_user.id, active: true))
			if @retailer_product.save
				upload_photos(@retailer_product)
				render template: 'api/v1/retailer_products/create.json.jbuilder'
			else
				render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: @retailer_product.errors.full_messages } }
			end
		end
	rescue StandardError => ex
		render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: ex.message } }
	end

	def update
		@retailer_product = RetailerProduct.find_by(id: params[:id])
		result = @retailer_product.update(product_params)
		if result
			render template: 'api/v1/retailer_products/update.json.jbuilder'
		else
			render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: @retailer_product.errors.full_messages } }
		end
	rescue StandardError => ex
		render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: ex.message } }
	end

	def destroy
		@retailer_product = RetailerProduct.find_by(id: params[:id])
		if @retailer_product.destroy
			render json: { meta: { code: t('authentication.status.success'), message: 'Product successfully deleted!' } }
		else
			render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: @retailer_product.errors.full_messages } }
		end
	rescue StandardError => ex
		render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: ex.message } }
	end

	private	
		def product_params
			params.require(:retailer_product).permit(:sku_code, :product_name, :price, :product_sub_category_id, :active, :description, :photos => [:lat, :lng, :photo])
		end

		def upload_photos(retailer_product)
			photos = product_params[:photos]
			if photos.present?
				Array.wrap(photos.values).each do |file|
					if file[:photo].present?
						file_path = "retailers/#{current_user.id}/products/#{retailer_product.id}/photos/"+file[:photo].original_filename
						result = FileUpload.new.upload(file_path, file[:photo])
						if String(result[:status]) == String(RESPONSE[:success])
							retailer_product_photo = retailer_product.retailer_product_photos.new(photo_url: result[:file_url])
							retailer_product_photo.lat = file[:lat]
							retailer_product_photo.lng = file[:lng]
							retailer_product_photo.save
						end
					end	
				end
			end
		end

end