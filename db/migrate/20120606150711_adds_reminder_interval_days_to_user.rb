class AddsReminderIntervalDaysToUser < ActiveRecord::Migration
  def change
    add_column :users, :reminder_interval_days, :integer, :default => 7

  end
end
