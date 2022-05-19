FactoryBot.define do
  factory :food do
    name { Faker::Food.ingredient }
    measurement_unit { Faker::Food.measurement }
    price { 1 }
    user { nil }
  end
end
