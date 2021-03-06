class RegistrationsController < Devise::RegistrationsController

  public

    def destroy
      if resource.cancel_account
        send_mails_notifications
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
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

    def send_mails_notifications
      @reason = CancelReason.t(params[:reason].to_i)
      @note = params[:note]
      NotificationMailer.notification_company(reason: @reason, note: @note).deliver_now
      NotificationMailer.notification_admin(reason: @reason, note: @note, company: resource).deliver_now
    end
    
    def sign_up_params
      params.require(:company).permit(:name, :email, :password, :password_confirmation, :type_company)
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

end