FactoryBot.define do
  factory :recipe do
    name { 'MyText' }
    preparation_time { 'MyString' }
    cooking_time { 'MyString' }
    description { 'MyText' }
    public { false }
    user { nil }
  end
end
