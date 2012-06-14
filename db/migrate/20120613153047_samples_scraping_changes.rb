class SamplesScrapingChanges < ActiveRecord::Migration
  def up
    change_table :samples do |t|
      t.string :description
      t.float :price
      t.string :url
      t.string :type, :default => "User"
    end
    Sample.update_all ["type = ?", "User"]
  end

  def down
    remove_column :samples, :description
    remove_column :samples, :price
    remove_column :samples, :url
    remove_column :samples, :type
  end
end
