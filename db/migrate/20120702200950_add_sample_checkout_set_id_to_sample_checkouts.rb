class AddSampleCheckoutSetIdToSampleCheckouts < ActiveRecord::Migration
  def change
    add_column :sample_checkouts, :sample_checkout_set_id, :integer
    
  end
end
