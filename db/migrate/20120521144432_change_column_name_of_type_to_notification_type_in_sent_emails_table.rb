class ChangeColumnNameOfTypeToNotificationTypeInSentEmailsTable < ActiveRecord::Migration
  def change
    rename_column :sent_emails, :type, :notification_type
  end
end
