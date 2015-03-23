class AddAndRenameStoreIngredients < ActiveRecord::Migration
  def change
    rename_column :store_ingredients, :name, :friendly_name
    rename_column :store_ingredients, :brand, :brand_and_item
    add_column :store_ingredients, :sku_quantity, :string
    remove_column :store_ingredients, :display_name
  end
end
