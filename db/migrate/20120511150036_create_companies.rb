class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website
      t.string :facebook
      t.string :sample_name, :default => "Sample"
      t.string :logo
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at

      t.timestamps
    end

    create_table :company_users do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
