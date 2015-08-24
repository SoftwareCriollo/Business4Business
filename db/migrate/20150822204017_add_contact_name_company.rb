class AddContactNameCompany < ActiveRecord::Migration
  def change
    add_column :companies, :contact_name, :string
  end
end
