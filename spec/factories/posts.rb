FactoryBot.define do
  factory :post do
    user
    content { Faker::Lorem.characters(number: 140) }
  end
end
