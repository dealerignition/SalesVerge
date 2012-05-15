class MoveUserActiveToCompanyUser < ActiveRecord::Migration
  def up
    add_column :company_users, :active, :boolean
    User.find_each do |user|
      user.company_users.find_each do |cu|
        cu.update_attribute :active, user.active
      end
    end
    remove_column :users, :active
  end

  def down
    add_column :users, :active, :boolean
    CompanyUser.find_each do |cu|
      cu.user.update_attribute :active, cu.active
    end
    remove_column :company_users, :active
  end
end
