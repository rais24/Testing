class RenameStoreIngredientsToProducts < ActiveRecord::Migration
  def change
  	rename_table :store_ingredients, :products
  end
end
