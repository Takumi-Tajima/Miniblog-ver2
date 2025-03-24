FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name.downcase }
    email { Faker::Internet.unique.email }
    password { 'password' }
    confirmed_at { Time.current }

    trait :without_confirmation do
      confirmed_at { nil }
    end
  end
end
