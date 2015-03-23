class ChangeStoreIngredientPriceToUseMoney < ActiveRecord::Migration
  def change
    remove_column :store_ingredients, :price
    add_money :store_ingredients, :price, amount: { null: false, default: nil }
  end
end
