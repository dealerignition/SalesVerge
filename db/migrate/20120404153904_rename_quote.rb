class RenameQuote < ActiveRecord::Migration
  def change
    rename_table :quotes, :estimates
  end
end
