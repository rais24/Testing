# == Schema Information
#
# Table name: order_products
#
#  id             :integer          not null, primary key
#  order_id       :integer
#  product_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  quantity       :integer
#  price_cents    :integer
#  price_currency :string(255)      default("USD"), not null
#  pantry         :boolean
#  cashback       :boolean
#

class OrderProduct < ActiveRecord::Base
  include Measureable
  belongs_to :order
  belongs_to :product

  scope :pantry, ->{ where(pantry: true) }

  delegate :unit, :sku, :measurement_type, :sku_quantity,
    :name, :brand_and_item, :amount, :confirmation_name,
    to: :product

  validates_presence_of :quantity, :order, :product
  monetize :price_cents, allow_nil: true

  def total_price
    return nil if product.nil? || product.price.nil?
    product.price * quantity
  end

  # quick legacy fix
  def brand
    brand_and_item
  end

end
