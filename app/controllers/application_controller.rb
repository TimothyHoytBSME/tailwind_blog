# Main App Actions

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
    
  protected
    def configure_permitted_parameters  #devise parameter setup
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :bio, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :bio, :current_password)}
    end  
end
