class OrdersRecipesJoin < ActiveRecord::Migration
  def up
  	create_table :orders_recipes, id: false do |t|
  		t.references :order
  		t.references :recipe
  	end
  end

  def down
  	drop_table :orders_recipes
  end
end
