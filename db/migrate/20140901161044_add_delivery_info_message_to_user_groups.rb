class AddDeliveryInfoMessageToUserGroups < ActiveRecord::Migration
  def change
  	UserGroup.reset_column_information
    add_column(:user_groups, :delivery_info_message, :text, null: true) unless UserGroup.column_names.include?('delivery_info_message')
  end
end
