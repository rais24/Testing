# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :store_ingredient do
    name "MyIngredient"
    brand "MyBrand"
    sku "ABC123"
    amount 3.0
    unit 1
    display_name "My Ingredient"
    price_cents 499
    price_currency "USD"
  end
end
