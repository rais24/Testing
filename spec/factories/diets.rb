# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diet do
    sequence(:name) { |n| "diet#{n}" }
    description "MyString"
  end
end
