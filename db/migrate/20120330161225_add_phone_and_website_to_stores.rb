class AddPhoneAndWebsiteToStores < ActiveRecord::Migration
  def change
    add_column :stores, :phone, :string
    add_column :stores, :website, :string
  end
end
