class AddDisplayTutorialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_tutorial, :boolean, :default => true
  end
end
