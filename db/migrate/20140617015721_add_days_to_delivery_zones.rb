class AddDaysToDeliveryZones < ActiveRecord::Migration
  def change
    add_column :delivery_zones, :days, :string
  end
end
