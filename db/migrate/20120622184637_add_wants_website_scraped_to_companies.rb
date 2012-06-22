class AddWantsWebsiteScrapedToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :wants_website_scraped, :boolean

  end
end
