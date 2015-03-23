# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :promo do
    code "promo1"
    quantity 25
    starts_on "#{Date.today}"
    ends_on "#{Date.today + 30}"
    discount_cents 2500
    active true
  end
end
