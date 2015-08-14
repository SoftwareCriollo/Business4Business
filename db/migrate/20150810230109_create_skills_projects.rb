class CreateSkillsProjects < ActiveRecord::Migration
  def change
    create_table :projects_skills, id: false do |t|
      t.belongs_to :skill, index: true
      t.belongs_to :project, index: true
    end
  end
end
