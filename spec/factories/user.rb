FactoryGirl.define do
  factory :user do

    first "John"
    last  "Doe"

    zipcode "12345"

    sequence(:email) { |n| "email#{n}@factory.com" }
    
    password "foobar23"
    password_confirmation { |u| u.password }

    adults 1
    children 1

    # delivery_site

    factory(:admin) { role :admin }
    factory(:invalid_user) { password nil }

    trait(:inactive) { active false }
    trait(:locked) { locked true }

    trait(:guest) do
      password nil
      password_confirmation nil
      guest true
      first nil
      last nil
      email ''
      adults 0
      children 0
    end

    trait(:eligible) do
      active true
      locked false
      guest false
    end

    trait(:with_adult) do
      eligible
      adults 1
      children 0
    end

    trait(:empty) do
      adults 0
      children 0
    end
  end
end