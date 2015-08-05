class AddCompleteProfileCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :complete_profile, :boolean, default: false
  end
end
