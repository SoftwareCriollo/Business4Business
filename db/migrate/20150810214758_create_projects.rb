class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.datetime :timeframes
      t.string :file
      t.float :budget
      t.timestamps
    end
  end
end
