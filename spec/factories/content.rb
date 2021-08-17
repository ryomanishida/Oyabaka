FactoryBot.define do
  factory :content do
    img { "#{Rails.root}/spec/fixtures/image/test.png" }
    title { Faker::Lorem.characters(number:30) }
    introduction { Faker::Lorem.characters(number:120) }
    user
  end
end