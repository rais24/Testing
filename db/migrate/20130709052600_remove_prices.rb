class RemovePrices < ActiveRecord::Migration
  def change
    remove_column :recipes, :price
    remove_column :recipe_portions, :price
    remove_column :ingredients, :price
    remove_column :order_servings, :price
    remove_column :order_portions, :price
    remove_column :delivery_servings, :price
    remove_column :delivery_portions, :price
    
    add_money :ingredients, :price
    add_money :order_portions, :price
    add_money :delivery_portions, :price
    add_money :orders, :price
    add_money :deliveries, :price
  end
end
