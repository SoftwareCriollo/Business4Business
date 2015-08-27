class FixColumnStatusToCompany < ActiveRecord::Migration
  def change
  	remove_column :companies, :status, :string, default: 'On_Hold'
  	add_column :companies, :status, :integer, default: 0
  end
end
