# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    scheduled_for Time.now
    association :user, factory: :user
  end
end
