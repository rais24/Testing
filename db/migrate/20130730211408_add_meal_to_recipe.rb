class AddMealToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :meal, :string, default: Recipe::MEALS.first, null: false
    add_index :recipes, :meal
    Recipe.find_each(&:save!)
  end
end
