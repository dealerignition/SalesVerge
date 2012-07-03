class CreateSampleCheckoutSets < ActiveRecord::Migration
  def change
    create_table :sample_checkout_sets do |t|
      t.references :sample_checkout
      t.integer :notifications_received
      t.timestamps
    end
  end
end
