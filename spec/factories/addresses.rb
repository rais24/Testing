# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street1 "123 Fake St"
    street2 ""
    phone ""
    first_name ""
   	last_name ""
    city "Fakeville"
    state "PA"
    zipcode "12345"
  end
end

