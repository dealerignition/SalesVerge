class PriceToText < ActiveRecord::Migration
  def up
    change_column :samples, :price, :string
  end

  def down
    change_column :samples, :price, :float
  end
end
