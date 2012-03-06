class CreateSampleCheckouts < ActiveRecord::Migration
  def change
    create_table :sample_checkouts do |t|
      t.references :customer
      t.references :sample
      t.datetime :checkout_time
      t.datetime :checkin_time
      t.timestamps
    end
  end
end
