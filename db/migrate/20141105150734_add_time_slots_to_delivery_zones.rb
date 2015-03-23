class AddTimeSlotsToDeliveryZones < ActiveRecord::Migration
  def change
 	DeliveryZone.reset_column_information
    add_column(:delivery_zones, :restricted_times, :string) unless DeliveryZone.column_names.include?('restricted_times')
  end
end
