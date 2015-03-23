# == Schema Information
#
# Table name: shopping_cart_items
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  owner_type :string(255)
#  quantity   :integer
#  item_id    :integer
#  item_type  :string(255)
#  price      :float
#

class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item

  belongs_to :item, foreign_key: 'item_id', foreign_type: 'item_type', polymorphic: true

end
