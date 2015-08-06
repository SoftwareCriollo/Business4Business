class CompaniesController < ApplicationController
  before_action :find_company

  def update
    @company.complete_profile = true
    if @company.update(company_params)
      redirect_to company_path(@company), notice: 'Company information edited successfully'
    else
      render 'edit'
    end
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

end
