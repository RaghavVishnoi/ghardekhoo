class Employees::RetailerProductsController < Employees::ApplicationController

	layout 'employee'

	def new
		@retailer = Retailer.find_by(access_token: params[:access_token])
		@retailer_product = @retailer.retailer_products.new
	end

	def create
		ActiveRecord::Base.transaction do
			@retailer = Retailer.new(retailer_params)
			if @retailer.save
				flash[:success] = t('retailers.signup_success')
			else
				@show_errors = true
				flash[:error] = @retailer.errors.full_messages.join('<br>')
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