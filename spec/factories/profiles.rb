FactoryBot.define do
  factory :profile do
    association :user
    content { 'a' * 1000 }
    address { 'a' * 10 }
    age { 30 }
    wages { 3000 }
  end
end
