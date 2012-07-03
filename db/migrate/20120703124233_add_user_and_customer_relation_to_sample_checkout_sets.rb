class AddUserAndCustomerRelationToSampleCheckoutSets < ActiveRecord::Migration
  def change
    change_table :sample_checkout_sets do |t|
      t.references :customer
      t.references :user
    end
  end
end
