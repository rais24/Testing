namespace :ingredient do
  desc "Convert all portion units to oz, lb, and unit"
  task convert: :environment do
    Ingredient.find_each do |ingredient|
      unit = ingredient.unit
      rps = RecipePortion.where(ingredient_id: ingredient.id)

      ingredient.unit = case unit

                        when "can" # = 16 fl oz
                          convert(rps, 96)
                          "tsp"
                        when "cup"
                          convert(rps, 48)
                          "tsp"
                        when "jar"
                          convert(rps, 48)
                          "tsp"
                        when "bag"
                          convert(rps, 36)
                          "tsp"
                        when "fl"
                          convert(rps, 6)
                          "tsp"
                        when "tbs"
                          convert(rps, 3)
                          "tsp"
                        when "tsp"
                          convert(rps, 1)
                          "tsp"

                        when "oz"
                          convert(rps, 1)
                          "oz"
                        when "lb"
                          convert(rps, 16)
                          "oz"


                        when "unit"
                          "unit"
                        when "clove"
                          "unit"
                        when "slice"
                          "unit"
                        else
                          puts "Cannot convert ingredient type #{unit}"
                        end
      ingredient.save!
    end
  end

  def convert(rps, multiplier)
    rps.each do |portion|
      portion.quantity = (portion.quantity * multiplier)
      portion.save
    end
  end
end