class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :file
      t.boolean :default, default: false
      t.integer :owner_id
      t.string  :owner_type
      t.timestamps
    end
  end
end
