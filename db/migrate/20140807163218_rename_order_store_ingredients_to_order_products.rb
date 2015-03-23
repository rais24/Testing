class RenameOrderStoreIngredientsToOrderProducts < ActiveRecord::Migration
  def change
  	rename_table :order_store_ingredients, :order_products
  end
end
