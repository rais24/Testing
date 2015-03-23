class AddQuantityToOrderStoreIngredient < ActiveRecord::Migration
  def change
    add_column :order_store_ingredients, :quantity, :integer
  end
end
