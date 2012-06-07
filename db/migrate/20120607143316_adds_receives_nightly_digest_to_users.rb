class AddsReceivesNightlyDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receives_nightly_digest, :boolean, :default => true, :after => :updated_at
  end
end
