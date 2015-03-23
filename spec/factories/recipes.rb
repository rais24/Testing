# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
    sequence(:name) { |n| "recipe-#{n}" }

    meal Recipe::MEALS.first
    
    preparation "1. Spread the Peanut Butter \n2. Spread the Jelly"

    published true

    trait(:unpublished) do
      published false
    end
  end
end
