class UserRequestRepliesController < ApplicationController

	def create
		@user_request_reply = UserRequestReply.new(user_request_reply_params.merge(user_id: current_user.id))
		if @user_request_reply.save
			flash[:success] = t('users.request_reply_success')
			@redirect_path = user_request_path(user_request_reply_params[:user_request_id])
		else
			@error = true
			flash[:error] = @user_request_reply.errors.full_messages.join('<br>')
		end
	# rescue StandardError => ex
	# 	flash[:error] = ex.message
	end

	private
		def user_request_reply_params
			params.require(:user_request_reply).permit(:user_request_id, :replied_by, :description)
		end

end