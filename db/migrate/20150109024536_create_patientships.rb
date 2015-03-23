class CreatePatientships < ActiveRecord::Migration
  def change
    create_table :patientships do |t|
      t.integer :patient_id, null: false
      t.integer :practitioner_id, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
