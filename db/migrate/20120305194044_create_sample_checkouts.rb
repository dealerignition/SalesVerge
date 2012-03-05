class CreateSampleCheckouts < ActiveRecord::Migration
  def change
    create_table :sample_checkouts do |t|
      t.integer :customer_id
      t.integer :sample_id
      t.datetime :checkout_time
      t.boolean :checked_in, :default => false

      t.timestamps
    end
  end
end
