class CreateSkillsProjects < ActiveRecord::Migration
  def change
    create_table :skills_projects, id: false do |t|
      t.belongs_to :skills, index: true
      t.belongs_to :projects, index: true
    end
  end
end
