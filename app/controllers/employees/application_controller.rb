class Employees::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_employee

  def access_denied
  	if current_user.blank?
  		flash[:error] = t('users.access_denied')
  		redirect_to new_employee_session_path
  	end
  end

  def current_employee
    @current_employee ||= Employee.find(session[:user_id]) if session[:user_id]
  end

end
