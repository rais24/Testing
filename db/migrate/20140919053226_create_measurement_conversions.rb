class CreateMeasurementConversions < ActiveRecord::Migration
  def change
    create_table :measurement_conversions do |t|
      t.string	   :measurement_type, null: false, default: ""
      t.decimal	   :measurement, null: false, default: 0.0
      t.string     :display_unit, null: false, default: ""
      t.string     :converted_measurement, null: false, default: ""
      t.timestamps
    end
  end
end
