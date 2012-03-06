class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
      t.references :dealer
    end

    change_table :samples do |t|
      t.references :store
    end
  end
end
