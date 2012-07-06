class RemoveNotificationsReceivedFromSampleCheckoutsAndAddCheckoutTimeAndCheckinTimeToSampleCheckoutSets < ActiveRecord::Migration
  def change
    remove_column :sample_checkouts, :notifications_received
    add_column :sample_checkout_sets, :checkout_time, :datetime
    add_column :sample_checkout_sets, :checkin_time, :datetime
  end
end
