# Public: when included, hooks up a listener to recalculate the price
#         when a record is saved.
#
# :calculate_price - Required in order to work. returns a Number
#
module Purchaseable
  extend ActiveSupport::Concern

  included do
    # recalculate the price if its unset
    before_validation do
      self.price = calculate_price
      true
    end

    monetize :price_cents
    
    def calculate_price
      Money.new(0)
    end
  end
end