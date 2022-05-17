class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages, :notice, :alert
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :password, :password_confirmation, :email, :image)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :password, :password_confirmation, :email, :current_password, :image)
    end
  end
end
