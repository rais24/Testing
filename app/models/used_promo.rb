# == Schema Information
#
# Table name: used_promos
#
#  id               :integer          not null, primary key
#  promo_id         :integer
#  order_id         :integer
#  shopping_cart_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class UsedPromo < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :order
  belongs_to :promo
  
  delegate :code, :amount_off, :discount, :discount_percent, to: :promo
  scope :used, ->{ joins(:order).where(orders: { checked_out: true }) }
end
