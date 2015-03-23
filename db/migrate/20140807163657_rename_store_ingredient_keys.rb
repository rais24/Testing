class RenameStoreIngredientKeys < ActiveRecord::Migration
  def change
	rename_column :order_products, :store_ingredient_id, :product_id
  end
end
