# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    sequence(:name) { |n| "ingredient-#{n}" }
    
    unit Ingredient::UNITS.first
    price Money.new(100)
    category Ingredient::CATEGORIES.first
  end
end
