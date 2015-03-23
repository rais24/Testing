# == Schema Information
#
# Table name: order_confirmations
#
#  id          :integer          not null, primary key
#  order_id    :integer
#  supplier    :string(255)
#  raw_message :text
#  send_date   :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  recipient   :string(255)
#

class OrderConfirmation < ActiveRecord::Base
  belongs_to :order

  after_create :associate_order

  attr_accessor :missing #should this be db backed?

  def associate_order
    begin
      parser = Orders::Parser.new raw_message
      update! order_id: parser.get_order
    rescue # if we fail, worst case we can associate by hand
    end
  end

  def ingredients
    parser = Orders::Parser.new raw_message
    parser.parse
  end

  def order_check
    missing_ingredients
    @missing
  end

  def missing_ingredients
    ingredients_missing_in_confirmation = []
    extra = []
    substituted_items = []
    order_ingredients = order.ingredient_check
    confirmed = ingredients
    # look through the orders ingredients and check to see if any aren't present in the confirmation
    order_ingredients.each do |row|
      found = confirmed.select {|ing| ing[:name] == row[:name]}
      if found.empty? # not found
        substituted = item_substituted_or_missing?(row[:sku]) 
        if substituted
          substituted_items << substituted
        else
          ingredients_missing_in_confirmation << {name: row[:name], quantity: row[:quantity]}
        end
      else
        # next check is to match quantities
        if found.first[:quantity] < row[:quantity]
          missing_amt = (found.first[:quantity] - row[:quantity]).abs
          ingredients_missing_in_confirmation << {name: row[:name], quantity: missing_amt}
          confirmed = confirmed.reject{|ing| ing[:name] == row[:name]}
        elsif found.first[:quantity] > row[:quantity]
          extra_amt = (row[:quantity] - found.first[:quantity]).abs
          extra << {name: row[:name], quantity: extra_amt}
          confirmed = confirmed.reject{|ing| ing[:name] == row[:name]}
        else
          confirmed = confirmed.reject{|ing| ing[:name] == row[:name]}
        end
      end
    end
    confirmed.each do |conf|
      if substituted_items.blank? || !item_substituted_or_extra?(substituted_items, conf[:name])
        extra << {name: conf[:name], quantity: conf[:quantity]}
      end
    end
    @missing = {ingredients: ingredients_missing_in_confirmation}
    
    @missing[:extras] = extra
  end

  private

  def item_substituted_or_missing? product_sku
    return nil if product_sku.blank?
    order.order_substitutions.each do |x|
      found_item = product_sku.strip == x.original_sku.strip
      return {id: x.id, substituted_confirmation_name: x.substituted_confirmation_name} if found_item
    end
    nil
  end

  def item_substituted_or_extra? substituted_items, confirmed_item
    substituted_items.each do |x|
      if confirmed_item == x[:substituted_confirmation_name] 
        return true
      elsif confirmed_item.include?(x[:substituted_confirmation_name])
        order_substitution = order.order_substitutions.find(x[:id])
        order_substitution.substituted_confirmation_name = confirmed_item
        order_substitution.save!    
        return true
      end
    end
    nil
  end

end
