class RemoveSampleCheckoutIdFromSampleCheckoutSets < ActiveRecord::Migration
  def up
    remove_column :sample_checkout_sets, :sample_checkout_id
  end

  def down
    add_column :sample_checkout_sets, :sample_checkout_id
  end
end
