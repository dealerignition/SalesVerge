class ScrapeChangeType < ActiveRecord::Migration
  def change
    rename_column :samples, :type, :creator
  end
end
