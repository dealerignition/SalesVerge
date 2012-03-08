class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.references :customer
      t.timestamps
    end
  end
end
