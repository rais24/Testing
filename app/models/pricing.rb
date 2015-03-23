# == Schema Information
#
# Table name: pricings
#
#  id          :integer          not null, primary key
#  min_serving :integer          not null
#  max_serving :integer          not null
#  price_cents :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Pricing < ActiveRecord::Base
  validates_presence_of :min_serving, :max_serving, :price_cents
  validates_uniqueness_of :min_serving, :max_serving
  validates_numericality_of :min_serving, :max_serving, :price_cents

  def self.serving_options_with_price(max_serving=8)
  	serving_options = {}
  	Pricing.order(min_serving: :asc).each do |pricing|
  		(pricing.min_serving..[max_serving,pricing.max_serving].min).step(2) do |n|
  			serving_options["#{n}"] = pricing.price_cents.to_f/100
  		end
  	end
  	serving_options
	end

  def self.max_price_per_serving
    Money.new(Pricing.maximum(:price_cents))
  end

 	def self.update(cart)
		cart.recipe_items.each do |r|
      price_per_recipe_serving = price_per_serving(r.quantity)
    	r.update_attribute(:price, price_per_recipe_serving) if price_per_recipe_serving
  	end
    cart.reload
 	end

 	def self.price_per_serving(servings) 
 		return Money.new(Pricing.minimum("price_cents")) if servings == 0
 		pricing = Pricing.where("min_serving <= :qty and max_serving >= :qty", qty: servings).select(&:price_cents).first
 		return nil unless pricing
 		Money.new(pricing.price_cents)
 	end

end
