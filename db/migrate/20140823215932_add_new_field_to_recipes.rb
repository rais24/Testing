class AddNewFieldToRecipes < ActiveRecord::Migration
  def change
  	Recipe.reset_column_information
    add_column(:recipes, :is_new, :boolean, null: false, default: false) unless Recipe.column_names.include?('is_new')
  end
end
