class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.date :date
      t.time :time
      t.references :customer
      t.string :appointment_type
      t.string :status

      t.timestamps
    end
  end
end
