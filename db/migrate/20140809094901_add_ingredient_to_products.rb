class AddIngredientToProducts < ActiveRecord::Migration
  def change
  	Product.reset_column_information
    add_column(:products, :ingredient_id, :integer) unless Product.column_names.include?('ingredient_id')
  end
end
