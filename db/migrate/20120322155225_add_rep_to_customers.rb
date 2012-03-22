class AddRepToCustomers < ActiveRecord::Migration
  def up
    add_column :customers, :user_id, :integer
  end

  def down
    remove_column :customers, :user_id
  end
end
