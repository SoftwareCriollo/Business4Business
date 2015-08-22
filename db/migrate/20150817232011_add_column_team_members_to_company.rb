class AddColumnTeamMembersToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :team_members, :integer, default: 0
  end
end
