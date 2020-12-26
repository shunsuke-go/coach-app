FactoryBot.define do
  factory :user do
    name { "山本" }
    email { Faker::Internet.email }
    password { "yamamoto" }
    password_confirmation { "yamamoto" }
  end
end
