class ScrapingConfigured < ActiveRecord::Migration
  def up
    change_table :companies do |t|
      t.boolean :scraping_configured, :default => false
    end
    Company.update_all ["scraping_configured = ?", false]
  end

  def down
    remove_column :companies, :scraping_configured
  end
end
