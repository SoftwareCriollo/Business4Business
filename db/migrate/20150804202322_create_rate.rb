class CreateRate < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :amount
      t.integer :type_company_id
      t.timestamps
    end
  end
end
