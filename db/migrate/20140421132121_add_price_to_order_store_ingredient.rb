class AddPriceToOrderStoreIngredient < ActiveRecord::Migration
  def change
    add_money :order_store_ingredients, :price, amount: { null: true, default: nil }
  end
end
