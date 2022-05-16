FactoryBot.define do
  factory :food do
    name { "MyText" }
    measurement_unit { "MyString" }
    price { 1 }
    user { nil }
  end
end
