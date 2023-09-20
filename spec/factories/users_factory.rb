# frozen-string-literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { :dealership }
    dealership

    trait :admin do
      role { :admin }
    end

    trait :dealership do
      role { :dealership }
    end
  end
end
