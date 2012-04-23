class RenameChargeEstimateIdBackToQuoteId < ActiveRecord::Migration
  def change
    rename_column :charges, :estimate_id, :quote_id
  end
end
