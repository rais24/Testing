class AddZoneToDeliveryTimes < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :delivery_times do |t|
        dir.up   { t.references :delivery_zone }
        dir.down { remove_column :delivery_times, :delivery_zone_id }
      end
    end
  end
end
