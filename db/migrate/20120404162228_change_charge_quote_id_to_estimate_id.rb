class ChangeChargeQuoteIdToEstimateId < ActiveRecord::Migration
  def change
    rename_column :charges, :quote_id, :estimate_id
  end
end
