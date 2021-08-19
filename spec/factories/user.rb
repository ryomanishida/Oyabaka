FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10)}
    email { Faker::Internet.email}
    password {"111111"}
    password_confirmation { '111111' }
  end
end