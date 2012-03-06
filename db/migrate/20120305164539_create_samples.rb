class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :dealer_sample_id
      t.string :name
      t.string :sample_type

      t.timestamps
    end
  end
end
