# frozen-string-literal: true

FactoryBot.define do
  factory :dealership do
    name { Faker::Name.name }
  end
end
