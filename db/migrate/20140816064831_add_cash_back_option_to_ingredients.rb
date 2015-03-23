class AddCashBackOptionToIngredients < ActiveRecord::Migration
  def change
  	Ingredient.reset_column_information
    add_column(:ingredients, :cash_back, :boolean, null: false, default: false) unless Ingredient.column_names.include?('cash_back')
  end
end
