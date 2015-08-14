class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.class.name == 'Company'
      if current_company_has_payment?
        current_company_has_complete_profile?
      else
        pay_path
      end
    else
      super
    end
  end
end
