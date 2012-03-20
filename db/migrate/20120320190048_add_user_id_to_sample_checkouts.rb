class AddUserIdToSampleCheckouts < ActiveRecord::Migration
  def change
    add_column :sample_checkouts, :user_id, :integer
  end
end
