class MergeDealersAndStoresToCompanies < ActiveRecord::Migration
  def quote_string(v)
      v.to_s.gsub(/\\/, '\&\&').gsub(/'/, "''")
  end

  def up
    add_column :samples, :company_id, :integer

    Sample.reset_column_information

    Dealer.find_each do |d|
      s = d.stores.first

      data = {
        :name => d.name,
        :sample_name => d.sample_name,
        :logo => d.logo,
        :logo_file_name => d.logo_file_name,
        :logo_content_type => d.logo_content_type,
        :logo_file_size => d.logo_file_size,
        :logo_updated_at => d.logo_updated_at,
        :created_at => d.created_at,
        :updated_at => Time.now
      }

      if s
        data.merge!({
          :address_1 => s.address_1,
          :address_2 => s.address_2,
          :city => s.city,
          :state => s.state,
          :zip => s.zip,
          :phone => s.phone,
          :website => s.website
        })
      end

      fields = data.keys.collect { |k| ":" + k.to_s }
      values = data.values.collect { |v| v.to_s == "" ? "NULL" : "\'#{quote_string(v)}\'" }
      query = ActiveRecord::Base.connection.execute("INSERT INTO companies (#{ data.keys.join(", ") }) VALUES(#{ values.join(", ")}) RETURNING id")
      id = query.values.first.first

      c = Company.find(id)
      puts "#{ c.id }: #{ c.name }"
      d.users.find_each do |u|
        case u.role
        when "salesrep", "owner"
          CompanyUser.create(
            :company => c,
            :user => u,
            :role => u.role
          )

          u.role = "user"
          u.save
        when "admin"
        end
      end

      if s
        s.samples.find_each do |sample|
          sample.company = c
          sample.save
        end
      end
    end

    drop_table :dealers
    drop_table :stores
    remove_column :users, :dealer_id
    remove_column :samples, :store_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
