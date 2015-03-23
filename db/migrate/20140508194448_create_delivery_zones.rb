class CreateDeliveryZones < ActiveRecord::Migration
  def change
    create_table :delivery_zones do |t|
      t.string :name
      t.timestamps
    end
    add_column :zipcodes, :delivery_zone_id, :integer
  end
end
