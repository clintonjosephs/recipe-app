FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'secret' }
    password_confirmation { password }
    confirmed_at { Time.now }
  end
end
