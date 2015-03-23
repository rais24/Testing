class AddNutritionToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :nutrition, :text
  end
end
