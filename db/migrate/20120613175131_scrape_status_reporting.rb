class ScrapeStatusReporting < ActiveRecord::Migration
  def up
    change_table :companies do |t|
      t.boolean :currently_scraping, :default => false
      t.datetime :last_scrape
    end
    Company.update_all ["currently_scraping = ?", false]
  end

  def down
    remove_column :companies, :currently_scraping
    remove_column :companies, :last_scrape
  end
end
