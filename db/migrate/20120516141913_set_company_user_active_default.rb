class SetCompanyUserActiveDefault < ActiveRecord::Migration
  def change
    change_column :company_users, :active, :boolean, :default => true
  end
end
