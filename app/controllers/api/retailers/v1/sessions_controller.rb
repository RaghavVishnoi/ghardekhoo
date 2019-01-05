class Api::Retailers::V1::SessionsController < Devise::SessionsController

	skip_before_action :verify_authenticity_token, only: [:create]	

	def create
		@retailer = Retailer.find_by(phone: session_params[:phone])
		if @retailer
			raise "Your account is not activated." if @retailer.account_status != 1
			unless @retailer.valid_password?(session_params[:password])
				render json: { meta: { code: t('authentication.status.failed'), errorDetail:  t('authentication.message.failed')} }
				return;
			end
			render template: 'api/retailers/v1/session.json.jbuilder'
		else
			render json: { meta: { code: t('authentication.status.failed'), errorDetail:  t('authentication.message.wrong_phone_account')} }
		end
	rescue StandardError => ex
		render json: { meta: { code: t('authentication.status.failed'), errorDetail:  ex.message} }
	end

	private
		def session_params
			params.require(:retailer).permit(:phone, :password)
		end

end