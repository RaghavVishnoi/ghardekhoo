class Api::V1::RetailerProductsController < Api::Retailers::ApisController

	def create
		@retailer_product = RetailerProduct.new(product_params.merge(retailer_id: current_user.id))
		if @retailer_product.save
			render template: 'api/v1/retailer_products/create.json.jbuilder'
		else
			render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: @retailer_product.errors.full_messages } }
		end
	end

	private	
		def product_params
			params.require(:retailer_product).permit(:sku_code, :product_name, :price, :product_sub_category_id)
		end

end