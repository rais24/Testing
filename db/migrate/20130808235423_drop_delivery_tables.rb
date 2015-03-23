class DropDeliveryTables < ActiveRecord::Migration
  def change
    drop_table :deliveries
    drop_table :delivery_portions
    drop_table :delivery_servings
  end
end
