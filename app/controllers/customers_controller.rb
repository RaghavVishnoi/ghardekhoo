class CustomersController < ApplicationController

	def create
		customer = Customer.find_by(email: customer_params[:email])
		customer = Customer.new(email: customer_params[:email]) if customer.blank?
		if customer.update(customer_params)
			flash[:success] = t('customers.query_submit')
		else
			@show_errors = true
			flash[:error] = customer.errors.full_messages.join('<br>')
		end
	rescue StandardError => ex
		@show_errors = true
		flash[:error] = ex.message
	end

	private
		def customer_params
			params.require(:customer).permit(:name, :email, :phone, :product_sub_categories_id, :description)
		end

end
