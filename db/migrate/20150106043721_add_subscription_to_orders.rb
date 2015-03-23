class AddSubscriptionToOrders < ActiveRecord::Migration
  def change
 	Order.reset_column_information
    add_column(:orders, :subscription_id, :integer) unless Order.column_names.include?('subscription_id')
  end
end
