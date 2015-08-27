class AddColumnStatusToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :status, :string, default: 'On_Hold'
  end
end
