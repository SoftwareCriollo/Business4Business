class RegistrationsController < Devise::RegistrationsController

  public
    
    def destroy
      if resource.cancel_account
        NotificationMailer.notification_company(reason: CancelReason.t(params[:reason].to_i), note: params[:note]).deliver_now
        NotificationMailer.notification_admin(reason: CancelReason.t(params[:reason].to_i), note: params[:note], company: resource).deliver_now
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        set_flash_message :notice, :destroyed if is_flashing_format?
        yield resource if block_given?
        respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
      else
        redirect_to cancel_account_path(resource), alert: 'Unable to unsubscribe, try again.'
      end
    end

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