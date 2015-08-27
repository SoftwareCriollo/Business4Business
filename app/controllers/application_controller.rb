class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    resource.after_sign_in_path
  end

  def current_ability
    if current_company
      @current_ability ||= Ability.new(current_company)
    else
      @current_ability ||= AbilityAdmin.new(current_admin_user)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
