class AddReceiveLowActivityMailerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_low_activity_mailer, :boolean, :default => true
  end
end
