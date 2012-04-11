class RemoveNotesFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :notes
  end
end
