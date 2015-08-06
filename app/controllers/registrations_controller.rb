class RegistrationsController < Devise::RegistrationsController

  protected

    def after_sign_up_path_for(resource)
      edit_company_path(current_company)
    end

  private
    def sign_up_params
      params.require(:company).permit(:name, :email, :password, :password_confirmation, :type_company)
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

end