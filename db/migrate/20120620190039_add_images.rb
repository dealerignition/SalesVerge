class AddImages < ActiveRecord::Migration
  def up
    change_table :companies do |t|
      t.string :image_location
      t.string :image_type
    end
    
    change_table :samples do |t|
      t.string :image_url
    end
  end

  def down
    remove_column :companies, :image_location
    remove_column :companies, :image_type
    remove_column :samples, :image_url
  end
end
