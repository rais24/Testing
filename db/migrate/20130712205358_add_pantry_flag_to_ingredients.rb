class AddPantryFlagToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :pantry, :boolean, default: false, null: false
  end
end
