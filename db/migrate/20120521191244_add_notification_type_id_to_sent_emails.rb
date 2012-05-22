class AddNotificationTypeIdToSentEmails < ActiveRecord::Migration
  def change
    add_column :sent_emails, :notification_type_id, :integer

  end
end
