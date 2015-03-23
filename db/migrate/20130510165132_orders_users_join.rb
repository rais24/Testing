class OrdersUsersJoin < ActiveRecord::Migration
  def up
  	create_table :orders_users do |t|
  		t.references :user
  		t.references :order
  	end
  end

  def down
  	drop_table :orders_users
  end
end