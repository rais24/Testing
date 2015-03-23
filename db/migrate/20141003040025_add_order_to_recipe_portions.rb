class AddOrderToRecipePortions < ActiveRecord::Migration
  def change
 	RecipePortion.reset_column_information
    add_column(:recipe_portions, :order, :integer, null: true) unless RecipePortion.column_names.include?('order')
  end
end
