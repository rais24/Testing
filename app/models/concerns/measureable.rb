# http://www.exploratorium.edu/cooking/convert/measurements.html
module Measureable
  extend ActiveSupport::Concern

  included do

    def units(servings = 1)
      "#{to_fraction(servings)} #{unit.pluralize(quantity) unless unit == 'unit'}"
    end

    def to_fraction(servings = 1)
      value = quantity * servings
      remainder = value % 1
      whole = value - remainder
      whole_string = whole.to_i.to_s

      num, den = remainder.to_fraction(32)

      fraction_string = den == 1 ? num : [num, den].join('/')

      if whole > 0
        if remainder ==0
          whole_string
        else
          "#{whole_string} & #{fraction_string}"
        end
      else
        fraction_string
      end
    end

    def get_parts(number)
      dec = number % 1
      int = number - dec
      int, dec = [int.to_i,  dec.round(2)]
    end

    def pluralize(number, text)
      if number != 1
        text.pluralize
      else
        text
      end
    end

    def to_display_amount(servings = 1, display_unit = nil)
      display_unit ||= unit

      case display_unit
      when "unit"
        convert_unit(servings)
      when "oz"
        convert_oz(servings)
      when "tsp"
        convert_tsp(servings)
      else
        puts "Unit '#{display_unit}' not recognized"
      end
    end

    def display_amount(scalar = 1, unit = "unit")
      if scalar == 0
        return "-"
      elsif scalar < 1 && unit == "tsp"
        return "to taste"
      elsif scalar < 1/8 && unit == "unit"
        return "a small portion"
      end

      int, dec = get_parts(scalar)

      num, den = dec.to_fraction(8)
      fraction_string = den == 1 ? num : [num, den].join('/')

      if int > 0
        if den == 0
          "#{int} #{pluralize(scalar, unit) unless unit == 'unit'}"
        elsif num == 0
          if int == 1
            "#{int} #{unit unless unit == 'unit'}"
          else
            "#{int} #{pluralize(scalar, unit) unless unit == 'unit'}"
          end
        else
          "#{int} & #{fraction_string} #{pluralize(scalar, unit) unless unit == 'unit'}"
        end
      else
        fraction_string
      end
    end

    # convert tsp to a readable amount
    # the quantity is always based on a single serving, but we'll always use 4 servings at a min
    def convert_tsp(servings = 1)
      value = quantity * servings

      measurement_conversion = MeasurementConversion.where(measurement_type: measurement_type, display_unit: "tsp", measurement: value).first
      return measurement_conversion.converted_measurement unless measurement_conversion.nil?

      if measurement_type == 'liquid'
        gallon, quart, cup, tbsp = [768,192,48,3]

        if value >= gallon
          gallons = value / gallon
          display_amount(gallons, "gallon")
        elsif value >= cup
          cups = value / cup
          display_amount(cups, "cup")
        elsif value >= tbsp
          tbsps = value / tbsp
          display_amount(tbsps, "TBSP")
        else
          display_amount(value, "tsp")
        end
      else # solid
        cup, hcup, tbsp = [48, 24, 3]
        if value >= cup
          cups = value / cup
          display_amount(cups, "cup")
        elsif value >= hcup
          cups = value / cup
          display_amount(cups, "cup")
        elsif value >= tbsp
          tbsps = value / tbsp
          display_amount(tbsps, "TBSP")
        else
          display_amount(value, "tsp")
        end
      end
    end

    def convert_oz(servings = 1)
      value = quantity * servings

      measurement_conversion = MeasurementConversion.where(measurement_type: measurement_type, display_unit: "oz", measurement: value).first
      return measurement_conversion.converted_measurement unless measurement_conversion.nil?

      if measurement_type == 'solid'
        lb = 16
        if value >= lb
          lbs = value / lb
          display_amount(lbs, "lb")
        else
          ozs = value
          display_amount(ozs, "oz")
        end
      else # liquid
        cup = 8
        if value >= cup
          cups = value / cup
          display_amount(cups, "cup")
        else
          display_amount(value, "oz")
        end
      end
    end

    def convert_unit(servings = 1)
      value = quantity * servings
      display_amount(value).strip
    end

    def determine_quantity(measure, quantity) 
      return quantity if unit.blank? || unit == "unit"

      if unit == measure
        quantity
      else
        if measurement_type == 'liquid'
          conversion_factors = {cup: 48, tbsp: 3, tsp: 1} if %w[cup tbsp tsp].include? unit
          conversion_factors = {lb: 16, oz: 1} if %w[oz lb].include? unit
        else
          conversion_factors = {lb: 16, oz: 1} if %w[oz lb].include? unit
        end

        if conversion_factors && conversion_factors[measure.to_sym] && conversion_factors[unit.to_sym]
          conv_ratio = conversion_factors[measure.to_sym] / conversion_factors[unit.to_sym]
        else
          conv_ratio = 1
        end
        conv_ratio * quantity
      end
    end
  
  end
end
