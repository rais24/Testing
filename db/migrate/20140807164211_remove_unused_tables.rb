class RemoveUnusedTables < ActiveRecord::Migration
  def change
  	drop_table :deliveries_delivery_sites
  	drop_table :delivery_sites
  	drop_table :diets_users
  	drop_table :diets
  end
end
