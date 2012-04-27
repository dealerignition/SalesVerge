class CreateCustomerExtensions < ActiveRecord::Migration
  def change
    create_table :customer_extensions do |t|
      t.integer :customer_id
      t.string :age
      t.string :gender
      t.string :marital_status
      t.string :education
      t.string :household_income
      t.string :home_owner_status
      t.string :home_market_value
      t.string :home_property_value
      t.string :length_of_residence
      t.string :zip
      t.string :occupation

      t.timestamps
    end
  end
end
