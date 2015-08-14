class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :company
      t.string :name
      t.text :description
      t.datetime :timeframes
      t.string :file
      t.float :budget
      t.timestamps
    end

    add_index :projects, [:company_id]
  end
end
