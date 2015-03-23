class DeliveriesOrdersJoin < ActiveRecord::Migration
  def up
  	create_table :deliveries_orders do |t|
  		t.references :delivery
  		t.references :order
  	end
  end

  def down
  	drop_table :deliveries_orders
  end
end
