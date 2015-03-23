FactoryGirl.define do
  factory :delivery_time do
    delivery_date Date.today
    time_slot "11-1"
    association :order, factory: :order
    association :delivery_zone, factory: :delivery_zone
  end
end
