module Quantifiable
  extend ActiveSupport::Concern

  included do
    validates_numericality_of :quantity, greater_than_or_equal_to: 0

    def empty?
      quantity <= 0
    end
  end
end