# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :signup_inquiry do
  	zipcode "12345"
    sequence(:email) { |n| "email#{n}@factory.com" }
    invite_code nil
  end
end
