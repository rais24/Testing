require File.expand_path('../../environment', __FILE__)

Replicate::AR

limit = ENV['LIMIT'].try(:to_i) || 20 

Ingredient.all.each { |ingredient| dump ingredient }
Recipe.all.each do |recipe|
  dump recipe
  dump recipe.portions
end