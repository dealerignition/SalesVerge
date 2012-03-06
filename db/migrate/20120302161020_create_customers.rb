class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone
      t.text   :notes

      t.timestamps
    end
  end
end
