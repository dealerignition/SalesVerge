class AddAppNameToAppRequests < ActiveRecord::Migration
  def change
    add_column :app_requests, :app_name, :string
  end
end
