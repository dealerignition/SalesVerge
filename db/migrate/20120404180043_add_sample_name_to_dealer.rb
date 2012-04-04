class AddSampleNameToDealer < ActiveRecord::Migration
  def change
    add_column :dealers, :sample_name, :string, :default => "Sample"
  end
end
