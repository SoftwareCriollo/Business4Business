class ChangeTypeCompany < ActiveRecord::Migration
  def change
    change_column :companies, :type_company, :string
    rename_column :companies, :type_company, :type
  end
end
