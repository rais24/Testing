class AddSlugToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :slug, :string
    add_index :ingredients, :slug
    
    Ingredient.find_each(&:save)
  end
end
