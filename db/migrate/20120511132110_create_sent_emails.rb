class CreateSentEmails < ActiveRecord::Migration
  def change
    create_table :sent_emails do |t|
      t.integer :customer_id
      t.string :type

      t.timestamps
    end
  end
end
