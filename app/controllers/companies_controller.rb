class CompaniesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_company!, only: [ :edit, :update, :index ]
  before_action :find_company, except: [ :new, :create, :type_company, :index ]
  before_action :check_paid, only: [ :update ]
  include ApplicationHelper

  def index
    @q = Company.list_filtered.ransack(params[:q])
    @companies = CompanyDecorator.decorate_collection(@q.result)
  end

  def new
    @type = params[:type]
    @company = Company.new(type: @type)
    render layout: "sign_up_company"
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      send_email_create_account
      sign_in @company
      redirect_to pay_path, notice: 'Company created successfully'
    else
      render 'new', layout: "sign_up_company"
    end
  end

  def update
    @company.complete_profile = true
    if @company.update(company_params)
      redirect_to company_path(@company), notice: 'Company information edited successfully'
    else
      render 'edit'
    end
  end

  def approve_request
    @company.approve_request_company
    redirect_to admin_company_path(@company.id)
  end

  def reject_request
    @company.reject_request_company
    redirect_to admin_company_path(@company.id)
  end

  def type_company
    render layout: "type_company"
  end

  def edit_account
    if @company.update(company_params)
      sign_in @company
      redirect_to my_account_path, notice: 'Account information edited successfully'
    else
      render 'my_account'
    end
  end

  def send_email_create_account
    NotificationMailer.notification_create_account(email: @company.email).deliver_now
  end

private

  def company_params
    params.require(name_class).permit(:name, :address, :contact_name, :website, :constitution_date, :description, :category_id, :tax_id, :address, :logo, :logo_cache, :type, :team_members, :email, :password, :password_confirmation, { skill_ids: [] }, pictures_attributes: pictures_attributes)
  end

  def pictures_attributes
    [
      :id, :file, :file_cache, :default, :_destroy
    ]
  end

  def find_company
    @company = Company.find(params[:id]).decorate
  end

  def check_paid
    unless @company.fee_paid?
      flash[:alert] = 'To complete registration is necessary to pay the fee, please click the "Pay Now" Button, to continue'
      @company.update(company_params)
      render 'edit'
    end
  end

end
