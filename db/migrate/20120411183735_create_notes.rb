class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user
      t.references :customer
      t.text :content

      t.timestamps
    end
  end
end
