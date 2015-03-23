class DeliveriesDeliverySitesJoin < ActiveRecord::Migration
  def up
  	create_table :deliveries_delivery_sites do |t|
      t.references :delivery
  		t.references :delivery_site
  	end
  end

  def down
  	drop_table :deliveries_delivery_sites
  end
end
