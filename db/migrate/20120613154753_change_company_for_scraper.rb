class ChangeCompanyForScraper < ActiveRecord::Migration
  def up
    change_table :companies do |t|
      t.string :description_location
      t.string :description_type
      t.string :name_location
      t.string :name_type
      t.string :price_location
      t.string :price_type
      t.string :product_number_location
      t.string :product_number_type
    end
  end

  def down
    remove_column :companies, :description_location
    remove_column :companies, :description_type
    remove_column :companies, :name_location
    remove_column :companies, :name_type
    remove_column :companies, :price_location
    remove_column :companies, :price_type
    remove_column :companies, :product_number_location
    remove_column :companies, :product_number_type
  end
end
