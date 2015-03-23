# == Schema Information
#
# Table name: order_portions
#
#  id             :integer          not null, primary key
#  quantity       :float            default(0.0), not null
#  order_id       :integer
#  ingredient_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  include        :boolean          default(TRUE), not null
#

class OrderPortion < ActiveRecord::Base
  include Measureable
  include Portionable

  belongs_to :order
  validates_presence_of :order

  scope :included, ->{ where(include: true) }
  scope :excluded, ->{ where(include: false) }

  def self.create_from_recipe_portion(portion, quantity: 0, to: nil)
    order_portion = to.portions.find_or_initialize_by ingredient_id: portion.ingredient.id
    order_portion.quantity += quantity * portion.quantity

    if order_portion.new_record?
      order_portion.include = !order_portion.pantry?
    end

    order_portion.save!
  end
end
