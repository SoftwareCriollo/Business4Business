class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :company
      t.float :amount
      t.timestamps
    end
  end
end
