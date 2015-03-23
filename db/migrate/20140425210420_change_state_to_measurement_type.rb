class ChangeStateToMeasurementType < ActiveRecord::Migration
  def change
    rename_column :ingredients, :state, :measurement_type
  end
end
