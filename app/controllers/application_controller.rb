class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:uid, :password) }
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:uid, :realname, :email, :phone, :password, :pasword_confirmation) }
  	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:uid, :realname, :email, :phone, :password, :pasword_confirmation, :avatar) }
  end

  protected

  def authenticate
  	unless authenticate_token || authenticate_user!
  		respond_to do |format|
  			format.json { render json: 'Bad credentails', status: 401 }
  			format.html { redirect_to new_user_session_path }
  		end
  	end
  end

  def authenticate_token
		authenticate_with_http_token do |token, options|
			User.find_by(authentication_token: token).present?
		end
	end
end
