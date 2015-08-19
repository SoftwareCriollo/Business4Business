class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: [ :edit, :update, :index ]
  before_action :find_company, except: [ :new, :create, :type_company, :index ]
  before_action :check_paid, only: [ :update ]
  include ApplicationHelper

  def index
    @q = Company.approved.profile_complete.ransack(params[:q])
    @companies = CompanyDecorator.decorate_collection(@q.result)
  end

  def new
    @type = params[:type]
    @companies = Company.new(type: @type)
    render layout: "sign_up_company"
  end

  def create
    @companies = Company.new(company_params)
    if @companies.save
      send_email_create_account(@companies)
      sign_in @companies
      redirect_to pay_path, notice: 'Company created successfully'
    else
      render 'new', layout: "public"
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

  def send_email_create_account(company)
    @email = company.email
    NotificationMailer.notification_create_account(email: @email).deliver_now
  end

private

  def company_params
    params.require(name_class).permit(:name, :address, :website, :constitution_date, :description, :category_id, :tax_id, :address, :logo, :type, :email, :password, :password_confirmation, skills: skill_attributes, contact_attributes: contact_params, pictures_attributes: pictures_attributes)
  end

  def contact_params
    [
      :id, :first_name, :last_name, :email, :phone
    ]
  end

  def skill_attributes
    [
      :id, :name
    ]
  end

  def pictures_attributes
    [
      :id, :file, :default, :_destroy
    ]
  end

  def find_company
    @company = Company.find(params[:id])
  end

  def check_paid
    unless @company.fee_paid?
      flash[:alert] = 'To complete registration is necessary to pay the fee, please click the "Pay Now" Button, to continue'
      @company.update(company_params)
      render 'edit'
    end
  end

end
