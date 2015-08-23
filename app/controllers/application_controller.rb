class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_authorization_check if :activeadmin_resource?

  def after_sign_in_path_for(resource)
    resource.after_sign_in_path
  end

  def current_ability
    @current_ability ||= Ability.new(current_company)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def activeadmin_resource?
    self.class.ancestors.include? ActiveAdmin::BaseController
  end
end
