# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  completed  :boolean          default(FALSE)
#

class ShoppingCart < ActiveRecord::Base
  acts_as_shopping_cart
  belongs_to :user

  # items
  has_many :recipe_items, -> { where("item_type = 'Recipe'") }, class_name: "ShoppingCartItem", as: :owner
  has_many :recipes, through: :recipe_items, source: :item, source_type: 'Recipe'

  has_many :recipe_portions, through: :recipes, source: :portions

  has_many :ingredients, -> { where("item_type = 'Ingredient'") }, class_name: "ShoppingCartItem", as: :owner
  has_one :used_promo
  
  has_one :order

  def tax_pct
    0.0
  end

  # overriding total because we need to handle discounts
  def total
    regular_total = sub_total
    if used_promo
      regular_total -= discount_from_promo
    end
    regular_total >= 0 ? ("%.2f" % regular_total).to_f : 0.0    
  end
  
  def discount_from_promo
    used_promo.amount_off(subtotal).to_f
  end
  
  #terrible name for this
  def sub_total
    (self.subtotal + self.taxes + self.shipping_cost)
  end

  def meals
    recipes.count
  end

  def servings
    recipe_items.map(&:quantity).inject(:+) || 0
  end

  def is_empty?
    servings == 0
  end

  def can_checkout?
    servings >= 8
  end

  def servings_needed_to_checkout
    8 - servings
  end

  def current_price_per_serving
    Pricing.price_per_serving(servings)
  end

  def get_ingredients
    ing = []
    recipes.each do |r|
      r.portions.each do |p|
        ing << "#{p.to_display_amount(r.quantity)} #{p.name.titleize}"
      end
    end
    ing
  end

  def groceries
    groceries = []
    recipes.each do |r|
      groceries << r.portions.groceries
    end
    groceries.flatten
  end

  def get_groceries
    groceries = []
    recipes.each do |r|
      r.portions.groceries.each do |g|
        groceries << [g.to_display_amount(r.quantity), g.name, g.id]
      end
    end
    groceries
  end

  def transfer_to_order order
    i = []
    # transfer only the recipes
    recipes.each do |r|
      r.portions.each do |p|
        i << {p => r.quantity}
      end
    end
    i.each do |ing, q|
      puts "Transfering #{ing.name} to order with quantity #{q}"
    end
  end
  
  def add_promo promo
    now = Date.today
    return false unless now.between?(promo.starts_on, promo.ends_on)
    return false if promo.total_used >= promo.quantity
    return false if user && user.used_promo_codes.include?(promo.code.downcase) && promo.code.downcase != "test"
    
    used_promo = build_used_promo(promo_id: promo.id)

    return true if used_promo.save
    return false
  end

end
