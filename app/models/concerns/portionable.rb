module Portionable
  extend ActiveSupport::Concern

  include Quantifiable

  included do
    belongs_to :ingredient

    validates_presence_of :ingredient

    delegate :unit, :pantry?, :name, :measurement_type, :category, :photo, to: :ingredient, allow_nil: true

    scope :pantry, -> { joins(:ingredient).merge(Ingredient.pantry) }
    scope :not_pantry, -> { joins(:ingredient).merge(Ingredient.not_pantry) }
    scope :produce, -> { joins(:ingredient).merge(Ingredient.produce) }
    scope :meats, -> { joins(:ingredient).merge(Ingredient.meats) }
    scope :groceries, -> { joins(:ingredient).merge(Ingredient.groceries) }
    scope :cash_back, -> { joins(:ingredient).merge(Ingredient.cash_back) }

    # def find_store_ingredient
    #   StoreIngredient.where "friendly_name like '%#{ingredient.name}%'"
    # end

    # def units(family_size = 1)
    #   "#{to_fraction(family_size)} #{unit.pluralize(quantity) unless unit == 'unit'}"
    # end
    #
    # def to_fraction(family_size = 1)
    #   value = quantity * family_size
    #   remainder = value % 1
    #   whole = value - remainder
    #   whole_string = whole.to_i.to_s
    #
    #   num, den = remainder.to_fraction(32)
    #
    #   fraction_string = den == 1 ? num : [num, den].join('/')
    #
    #   if whole > 0
    #     if remainder ==0
    #       whole_string
    #     else
    #       "#{whole_string} & #{fraction_string}"
    #     end
    #   else
    #     fraction_string
    #   end
    # end
    #
    # def get_parts(number)
    #   dec = number % 1
    #   int = number - dec
    #
    #   int, dec = [int.to_i,  dec.round(2)]
    # end
    #
    # def pluralize(number, text)
    #   if number != 1
    #     text.pluralize
    #   else
    #     text
    #   end
    # end
    #
    # def to_display_amount(family_size = 1, display_unit = nil)
    #   display_unit ||= unit
    #
    #   case display_unit
    #   when "unit"
    #     convert_unit(family_size)
    #   when "oz"
    #     convert_oz(family_size)
    #   when "tsp"
    #     convert_tsp(family_size)
    #   else
    #     puts "Unit '#{display_unit}' not recognized"
    #   end
    # end
    #
    # def display_amount(scalar = 1, unit = "unit")
    #   if scalar == 0
    #     return "-"
    #   elsif scalar < 1 && unit == "tsp"
    #     return "to taste"
    #   elsif scalar < 1/8 && unit == "unit"
    #     return "a small portion"
    #   end
    #
    #   int, dec = get_parts(scalar)
    #
    #   num, den = dec.to_fraction(8)
    #   fraction_string = den == 1 ? num : [num, den].join('/')
    #
    #   if int > 0
    #     if den == 0
    #       "#{int} #{pluralize(scalar, unit) unless unit == 'unit'}"
    #     elsif num == 0
    #       if int == 1
    #         "#{int} #{unit unless unit == 'unit'}"
    #       else
    #         "#{int} #{pluralize(scalar, unit) unless unit == 'unit'}"
    #       end
    #     else
    #       "#{int} & #{fraction_string} #{pluralize(scalar, unit) unless unit == 'unit'}"
    #     end
    #   else
    #     fraction_string
    #   end
    # end
    #
    # def convert_tsp(family_size = 1)
    #   value = quantity * family_size
    #
    #   gallon, quart, pint, cup, fl_oz, tsbp = [768,192,96,48,6,3]
    #
    #   if value >= gallon
    #     gallons = value / gallon
    #     display_amount(gallons, "gallon")
    #
    #   elsif value >= quart
    #     quarts = value / quart
    #     display_amount(quarts, "quart")
    #
    #   elsif value >= pint
    #     pints = value / pint
    #     display_amount(pints, "pint")
    #
    #   elsif value >= cup
    #     cups = value / cup
    #     display_amount(cups, "cup")
    #
    #   elsif value >= fl_oz
    #     fl_ozs = value / fl_oz
    #     display_amount(fl_ozs, "oz")
    #
    #   elsif value >= tsbp
    #     tbsps = value / tsbp
    #     display_amount(tbsps, "tbsp")
    #
    #   else
    #     tsps = value
    #     display_amount(tsps, "tsp")
    #   end
    # end
    #
    # def convert_oz(family_size = 1)
    #   value = quantity * family_size
    #   lb = 16
    #
    #   if value >= lb
    #     lbs = value / lb
    #     display_amount(lbs, "lb")
    #   else
    #     ozs = value
    #     display_amount(ozs, "oz")
    #   end
    # end
    #
    # def convert_unit(family_size = 1)
    #   value = quantity * family_size
    #   display_amount(value).strip
    # end
  end
end
