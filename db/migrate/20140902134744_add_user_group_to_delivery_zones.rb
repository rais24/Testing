class AddUserGroupToDeliveryZones < ActiveRecord::Migration
  def change
 	DeliveryZone.reset_column_information
    add_column(:delivery_zones, :user_group_id, :integer, null: true) unless DeliveryZone.column_names.include?('user_group_id')
  end
end
