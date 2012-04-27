class AddSubscriptionToExtendedInformationBooleanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribes_to_customer_extensions, :boolean, :default => false

  end
end
