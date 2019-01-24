class Api::Users::V1::RegistrationsController < Devise::RegistrationsController

	skip_before_action :verify_authenticity_token, only: [:create]

	def create
		
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
