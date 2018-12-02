class Api::ApisController < ApplicationController
  before_action :authenticate_user

  private

  def authenticate_user
    authenticate_or_request_with_http_token do |token, _options|
      sign_in(token)
    end
  end

  # def sign_in(token)
  #   @current_user = User.find_by(token: token)
  #   if @current_user
  #     @current_user
  #   else
  #     render json: { meta: { code: t('authentication.status.failed'), errorDetail: t('authentication.message.failed') } }
  #   end
  #   end

  attr_reader :current_user
end
