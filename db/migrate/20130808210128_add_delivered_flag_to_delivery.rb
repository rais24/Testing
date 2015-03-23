class AddDeliveredFlagToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivered, :boolean
    remove_column :deliveries, :status
  end
end
