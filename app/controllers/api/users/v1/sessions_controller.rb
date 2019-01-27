class Api::Users::V1::SessionsController < Api::Users::ApisController

	skip_before_action :authenticate_user, only: [:create]

	def create
		if params[:login_type] == 'social'
	        # Login via google
	        if params[:user][:google_access_token]
	        	google_params = extra_google_information
	        	@user = User.find_or_initialize_by(google_user_id: google_params[:google_user_id])
		        if  @user.update(
			            user_params.merge(google_params)
			        )
		        	render template: 'api/users/v1/session.json.jbuilder'
			    else
			    	render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: @user.errors.full_messages.join(',') } }	
			    end
	        	# Login via facebook
	        else
		        facebook_params = extra_facebook_information
		        @user = User.find_or_initialize_by(facebook_user_id: facebook_params[:facebook_user_id])
		        if  @user.update(
			            user_params.merge(facebook_params)
			        )
		        	@user.update(photo_url: FacebookProfilePicture.new(@user).url)
		        	render template: 'api/users/v1/session.json.jbuilder'
			    else
			    	render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: @user.errors.full_messages.join(',') } }	
			    end
	        end
	    else
	    	@user = User.find_by(email: user_params[:email])
	    	if @user.present?
	    		unless @user.valid_password?(user_params[:password])
					render json: { meta: { code: t('authentication.status.failed'), errorDetail:  t('authentication.message.failed')} }
					return;
				end
				render template: 'api/users/v1/session.json.jbuilder'
	    	else
	    		render json: { meta: { code: t('authentication.status.failed'), errorDetail:  t('authentication.message.failed')} }
	    	end
	    end
	rescue StandardError => ex
		render json: { meta: { code: t('authentication.status.failed'), errorDetail:  ex.message} }
	end


	private

	def user_params
	    params.require(:user)
		  .permit(
		    :first_name,
		    :last_name,
		    :email,
		    :username,
		    :facebook_user_id,
		    :facebook_user_token,
		    :gender,
		    :bio,
		    :phone,
		    :google_user_id,
		    :lat,
		    :lng,
		    :password
		)
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

	def extra_google_information
	    {
	      first_name: google_client[:given_name],
	      last_name: google_client[:family_name],
	      email: google_client[:email],
	      google_user_id: google_client[:id],
	      gender: google_client[:gender],
	      photo_url: google_client[:picture]
	    }
	end

	def facebook_client
	    @facebook_client ||= FacebookDigitAuth::BestAuth.access_data(facebook_user_token, 'facebook').with_indifferent_access
	end

	def google_client
	    @google_client ||= FacebookDigitAuth::BestAuth.access_data(google_user_token, 'google').with_indifferent_access
	    if @google_client[:code] == t('authentication.status.success')
	      @google_client[:data]
	    else
	      raise @google_client[:error]
	    end
	end

	def facebook_user_token
	    params[:user][:facebook_user_token]
	end

	def google_user_token
	    params[:user][:google_access_token]
	end

end