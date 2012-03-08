class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.datetime :date
      t.text :description
      t.float :quantity
      t.float :price

      t.references :quote
      t.timestamps
    end
  end
end
