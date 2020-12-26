FactoryBot.define do
  factory :profile do
    association :user
    content { "a" * 1000}
    address { "a" * 50 }
    age { 30 }
  end
end
