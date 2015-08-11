class CreateSkillsCompanies < ActiveRecord::Migration
  def change
    create_table :companies_skills, id: false do |t|
      t.belongs_to :skill, index: true
      t.belongs_to :company, index: true
    end
  end
end
