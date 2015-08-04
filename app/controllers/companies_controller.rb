class CompaniesController < ApplicationController

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to edit_company_path(@company), notice: 'Company information edited successfully'
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

end
