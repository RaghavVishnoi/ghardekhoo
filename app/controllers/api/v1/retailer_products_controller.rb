class Api::V1::RetailerProductsController < Api::Retailers::ApisController

	def create
		@retailer_product = RetailerProduct.find_by(sku_code: product_params[:sku_code], retailer_id: current_user.id)
		if @retailer_product.present?
			@retailer_product.update(active: true)
			render template: 'api/v1/retailer_products/create.json.jbuilder'
		else
			@retailer_product = RetailerProduct.new(product_params.merge(retailer_id: current_user.id, active: true))
			if @retailer_product.save
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

	private	
		def product_params
			params.require(:retailer_product).permit(:sku_code, :product_name, :price, :product_sub_category_id, :active)
		end

end