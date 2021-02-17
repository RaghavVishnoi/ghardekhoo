class Employees::RetailersController < Employees::ApplicationController

	layout 'employee'

	def index
		@retailers = current_employee.retailers.includes(:retailer_products).page(params[:page]).per(RETAILERS_PER_PAGE)
	end

	def new
		action = request.url.split('/').last
		@account_type = action == 'advertise' ? 'premium' : 'free'
		@retailer = Retailer.new
	end

	def create
		ActiveRecord::Base.transaction do
			@retailer = Retailer.new(retailer_params)
			if @retailer.save
				@redirect_url = '/employees/'+@retailer.access_token+'/retailer_products/new'
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
		def retailer_params
			params.require(:retailer).permit(
		    	:adhaar_number,
		    	:pan_number,
		    	:first_name,
		    	:last_name,
		    	:phone,
		    	:email,
		    	:address,
		    	:city,
		    	:state,
		    	:country,
		    	:employee_id,
		    	:account_type
		    )
		end

end