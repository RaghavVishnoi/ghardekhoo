class UserRequestsController < ApplicationController

	before_action :access_denied, only: [:index, :new]

	def index
		@requests = current_user.user_requests.where(active: true).order('created_at')
		@requests = @requests.page(params[:page]).per(REQUESTS_PER_PAGE)
	end

	def new
		@user_request = UserRequest.new
	end

	def create
		@user_request = UserRequest.new(user_request_params.merge(user_id: current_user.id))
		if @user_request.save
			@user_operation = true
			flash[:success] = t('users.request_success')
		else
			flash[:error] = @user_request.errors.full_messages.join('<br>')
		end
	rescue StandardError => ex
		flash[:error] = ex.message
	end

	def show
		@user_request = UserRequest.find_by(id: params[:id])
	end

	def destroy
		@user_request = UserRequest.find_by(id: params[:id])
		if @user_request.update(active: false)
			flash[:success] = t('users.request_delete')
			redirect_to user_requests_path
		else
			flash[:error] = @user_request.errors.full_messages.join('<br>')
		end
	end

	private
		def user_request_params
			params.require(:user_request).permit(
				:product_category_id, 
				:product_sub_category_id, 
				:status, 
				:subject, 
				:description
			)
		end

end