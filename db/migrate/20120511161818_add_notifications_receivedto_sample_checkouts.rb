class AddNotificationsReceivedtoSampleCheckouts < ActiveRecord::Migration
  def change
    add_column :sample_checkouts, :notifications_received, :integer, :default => 0

  end
end
