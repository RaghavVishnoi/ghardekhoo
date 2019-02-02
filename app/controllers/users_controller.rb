class UsersController < ApplicationController

	before_action :google_user_params, only: [:google_login]

	def google_login
		@user = User.find_or_initialize_by(google_user_id: @params[:google_user_id])
		unless @user.update(@params)
			flash[:error] = @user.errors.full_messages.join(',')
		end
		session[:user_id] = @user.id
		redirect_to root_path
	rescue StandardError => ex
		flash[:error] = ex.message
		redirect_to user_session_path
	end

	def facebook_login
		facebook_params = extra_facebook_information
		@user = User.find_or_initialize_by(facebook_user_id: facebook_params[:facebook_user_id])
		if @user.update(extra_facebook_information)
			@login = true
			@user.update(photo_url: FacebookProfilePicture.new(@user).url)
			session[:user_id] = @user.id
		else
			flash[:error] = @user.errors.full_messages.join(',')
		end
	rescue StandardError => ex
		flash[:error] = ex.message
	end

	private
		def google_user_params
			@params = {}
			user_params = request.env['omniauth.auth']
			google_id = user_params['uid']
			@params[:google_user_id] = google_id
			extra_google_info = user_params.extra
			raw_info = extra_google_info.raw_info
			@params[:email] = raw_info['email']
			@params[:first_name] = raw_info['given_name']
			@params[:last_name] = raw_info['family_name']
			@params[:gender] = raw_info['gender']
			@params[:photo_url] = raw_info['picture']
			@params
		end

		def extra_facebook_information
			{
			  first_name: facebook_client[:first_name],
			  last_name: facebook_client[:last_name],
			  email: facebook_client[:email],
			  facebook_user_id: facebook_client[:id],
			  gender: facebook_client[:gender]
			}
		end

		def facebook_client
		    @facebook_client ||= FacebookDigitAuth::BestAuth.access_data(facebook_user_token, 'facebook').with_indifferent_access
		end

		def facebook_user_token
			params[:access_token]
		end

end