# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  friendly_name     :string(255)
#  brand_and_item    :string(255)
#  sku               :string(255)
#  amount            :decimal(10, 2)
#  unit              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  price_cents       :integer          not null
#  price_currency    :string(255)      default("USD"), not null
#  sku_quantity      :string(255)
#  confirmation_name :string(255)
#  ingredient_id     :integer
#

class Product < ActiveRecord::Base
  has_many :orders, through: :order_products
  has_many :order_products
  has_and_belongs_to_many :stores
  belongs_to :ingredient

  validates_presence_of :friendly_name, :unit, :amount
  monetize :price_cents

  default_scope { order('TRIM(LOWER(friendly_name)) asc') }

  # for legacy issues
  def name
    friendly_name
  end

  def show_name
    "#{name} - <span class='price'>#{ActionController::Base.helpers.number_to_currency(Money.new(price))}</span>
      <br/>
      #{display_name}
    ".html_safe
  end

  def measurement_type
    ''
  end

  def self.show_amt_needed_from_portion(portion, quantity: 0)
    order_portion = OrderPortion.find_or_initialize_by ingredient_id: portion.ingredient.id
    order_portion.quantity += quantity * portion.quantity

    if order_portion.new_record?
      order_portion.include = !order_portion.pantry?
    end

    order_portion.quantity
  end
end
