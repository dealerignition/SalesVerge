class RemoveAppointments < ActiveRecord::Migration
  def up
    drop_table :appointments
  end

  def down
    raise ActiveRecord::IrrversibleMigration
  end
end
