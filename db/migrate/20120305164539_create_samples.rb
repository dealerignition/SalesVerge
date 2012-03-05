class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :sample_id
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
