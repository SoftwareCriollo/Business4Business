class RegistrationsController < Devise::RegistrationsController

  protected

  private
    def sign_up_params
      params.require(:company).permit(:email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:company).permit(:name, :address, :website, :constitution_date, :description, :category_id, :tax_id, :address, :logo, :type_company, :email, :password, :password_confirmation, contact_attributes: contact_params)
    end

    def contact_params
      [
        :id, :first_name, :last_name, :email, :phone
      ]
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

end