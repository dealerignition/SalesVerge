class SamplesDescriptionIncrease < ActiveRecord::Migration
  def up
    change_column :samples, :description, :text
  end

  def down
    change_column :samples, :description, :string
  end
end
