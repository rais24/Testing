# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_store_ingredient do
    association :order, factory: :order
    association :store_ingredient, factory: :store_ingredient
    quantity 1
    price_cents 499
    price_currency "USD"
  end
end
