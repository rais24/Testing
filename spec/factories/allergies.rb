# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :allergy do
    sequence(:name) { |n| "diet#{n}" }
    description "MyString"
  end
end
