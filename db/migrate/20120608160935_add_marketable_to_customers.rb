class AddMarketableToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :marketable, :boolean, :default => false
  end
end
