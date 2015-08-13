class CompaniesController < ApplicationController
  before_action :find_company, except: [ :new, :create, :type_company ]
  before_action :check_paid, only: [ :update ]

  def new
    @companies = Company.new()
    render layout: "public"
  end

  def create
    @companies = Company.new(company_params)
    if @companies.save
      sign_in @companies
      redirect_to edit_company_path(@companies), notice: 'Company created successfully'
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
    render layout: "public"
  end

private

  def company_params
    params.require(:company).permit(:name, :address, :website, :constitution_date, :description, :category_id, :tax_id, :address, :logo, :type_company, :email, :password, :password_confirmation, contact_attributes: contact_params)
  end

  def contact_params
    [
      :id, :first_name, :last_name, :email, :phone
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
