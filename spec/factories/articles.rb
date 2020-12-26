FactoryBot.define do
  factory :article do
    association :user
    title { "a" * 15 }
    content { Faker::Lorem.sentence }
  end
end
