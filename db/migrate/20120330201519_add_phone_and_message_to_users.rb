class AddPhoneAndMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :message, :text, :default => "Please contact me at any time if you have any questions."
  end
end
