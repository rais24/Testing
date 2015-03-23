class ChangeAmountTypeInStoreIngredients < ActiveRecord::Migration
  def change
		change_column :store_ingredients, :amount, :decimal, precision: 10, scale: 2
	end   	
end
