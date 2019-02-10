class UserRequestsController < ApplicationController

	before_action :access_denied, only: [:new]

	def new
		@user_request = UserRequest.new
	end

	def create
		@user_request = UserRequest.new(user_request_params.merge(user_id: current_user.id))
		if @user_request.save
			@user_operation = true
			flash[:success] = t('users.request_success')
		else
			flash[:error] = @user_request.errors.full_messages.join(',')
		end
	rescue StandardError => ex
		flash[:error] = ex.message
	end

	private
		def user_request_params
			params.require(:user_request).permit(:product_category_id, :product_sub_category_id, :status, :subject, :description)
		end

end