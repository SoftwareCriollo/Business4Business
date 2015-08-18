class AddDefaultTypeCompanies < ActiveRecord::Migration
  def change
    change_column :companies, :type, :string, default: 'Company'
  end
end
