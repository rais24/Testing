class AddIncludeToRecipePortions < ActiveRecord::Migration
  def change
    add_column :recipe_portions, :include, :boolean, default: true, null: false
    RecipePortion.find_each(&:save!)
  end
end
