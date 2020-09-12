class CreateMedicalAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_appointments do |t|
      t.references :patient, foreign_key: true
      t.references :employee, foreign_key: true
      t.date :scheduled_at
      t.string :start_time
      t.string :finish_time
      t.text :description

      t.timestamps
    end
  end
end
