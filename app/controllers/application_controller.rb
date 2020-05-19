class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user

  def access_denied
  	if current_user.blank?
  		flash[:error] = t('users.access_denied')
  		redirect_to root_path
  	end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
