FactoryBot.define do
  factory :vehicle do
    brand { Faker::Name.name }
    name { Faker::Name.name }
    model { Faker::Name.name }
    year { Faker::Date.in_date_period.year }
    dealership
  end
end
