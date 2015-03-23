class AddPriceAndDisplayNameToStoreIngredients < ActiveRecord::Migration
  def change
    add_column :store_ingredients, :price, :float
    add_column :store_ingredients, :display_name, :string
  end
end
