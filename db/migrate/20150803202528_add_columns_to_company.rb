class AddColumnsToCompany < ActiveRecord::Migration
  def change
    add_reference :companies, :category, index: true, foreign_key: true
    add_column :companies, :name, :string
    add_column :companies, :description, :string
    add_column :companies, :tax_id, :string
    add_column :companies, :constitution_date, :datetime
    add_column :companies, :logo, :string
    add_column :companies, :country, :integer
    add_column :companies, :state, :integer
    add_column :companies, :city, :integer
    add_column :companies, :address, :string
    add_column :companies, :website, :string
    add_column :companies, :type_company, :integer
  end
end
