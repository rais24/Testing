class MapIngredientsToProducts < ActiveRecord::Migration
  def change
  	Ingredient.all.each_with_index do |ingredient|
  		ingredient_friendly_name = "%#{ingredient.name.squish.downcase}%"
  		product = Product.where("LOWER(friendly_name) like ?", ingredient_friendly_name).first
  		if product.present? && product.ingredient.blank?
	  		puts "Ingredient #{ingredient.id}, Product #{product.id}"
	  		product.ingredient = ingredient
	  		product.save!
	  	elsif product.ingredient.blank?
	  		puts "Ingredient #{ingredient.id}, Product #{product.id} is already mapped"
	  	elsif product.blank?
	  		puts "Ingredient #{ingredient.id} has no match"
  		end
  	end
  end
end
