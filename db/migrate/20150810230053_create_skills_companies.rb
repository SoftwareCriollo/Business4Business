class CreateSkillsCompanies < ActiveRecord::Migration
  def change
    create_table :skills_companies, id: false do |t|
      t.belongs_to :skills, index: true
      t.belongs_to :companies, index: true
    end
  end
end
