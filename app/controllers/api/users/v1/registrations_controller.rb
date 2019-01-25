class Api::Users::V1::RegistrationsController < Devise::RegistrationsController

	skip_before_action :verify_authenticity_token, only: [:create]

	def create
		ActiveRecord::Base.transaction do
			build_resource(sign_up_params)
			if resource.save
				@user = resource
				render template: 'api/users/v1/registration.json.jbuilder'
			else
				render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: Errors.customize(resource.errors.full_messages).join(',') } }
			end
		end
	rescue StandardError => ex	
		resource.destroy if resource.present?
		render json: { meta: { code: t('authentication.status.unprocessible_entity'), errorDetail: ex.message } }
	end	

	private

	  # Notice the name of the method
	  def sign_up_params
	    params.require(:user).permit(
	    	:first_name,
	    	:last_name,
	    	:phone,
	    	:email,
	    	:password,
	    	:password_confirmation,
	    	:lat,
	    	:lng,
	    	:photo_url
	    )
	  end

end
