# == Schema Information
#
# Table name: order_servings
#
#  id         :integer          not null, primary key
#  quantity   :float            default(0.0), not null
#  order_id   :integer
#  recipe_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class OrderServing < ActiveRecord::Base
  include Servable

  belongs_to :order
  validates_presence_of :order
  
  delegate :price_per_serving, to: :order
  
  #before_save :update_quantity
  #after_save :update_order # update the price
  
  def update_quantity
    begin
      self.quantity = order.user_family_size
    rescue Exception => e
      logger.info(e.message)
    end
  end
  
  def update_order
    begin
      order.calculate_price!
    rescue Exception => e
      logger.info(e.message)
    end
  end
  
  # takes the price per order, and totals it depending on quantity
  def total_price
    Money.new(quantity * price_per_serving)
  end
end
