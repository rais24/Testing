# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :delivery_site do
    sequence(:subdomain) { |n| "subdomain_#{n}"}
    sequence(:promo_code) { |n| "promo_code_#{n}"}

    name "Mock Site"

    street "123 Fake St"
    city "Fakeville"
    state "PA"
    zip "12345"
  end
end