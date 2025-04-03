FactoryBot.define do
  factory :comment do
    user
    post
    content { "MyText" }
  end
end
