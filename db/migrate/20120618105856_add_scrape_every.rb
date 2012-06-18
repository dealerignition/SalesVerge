class AddScrapeEvery < ActiveRecord::Migration
  def up
    change_table :companies do |t|
      t.integer :run_every_x_days, :default => 7
    end
    Company.update_all ["run_every_x_days = ?", 7]
  end

  def down
    remove_column :companies, :run_every_x_days
  end
end
