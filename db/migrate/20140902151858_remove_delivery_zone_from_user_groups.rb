class RemoveDeliveryZoneFromUserGroups < ActiveRecord::Migration
  def change
  	remove_column :user_groups, :delivery_zone_id
  end
end
