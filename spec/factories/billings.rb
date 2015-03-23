# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :billing do
    sequence(:token) { |n| "#{provider}_token_#{n}" }
    
    provider :stripe
    customer_id "Q4icngIg21XEnl6z"
  end
end
