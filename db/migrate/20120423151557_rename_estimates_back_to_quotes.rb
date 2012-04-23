class RenameEstimatesBackToQuotes < ActiveRecord::Migration
  def change
    rename_table :estimates, :quotes
  end
end
