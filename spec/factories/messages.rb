FactoryBot.define do
  factory :message do
    association :user
    association :room
    content { 'a' * 300 }
  end
end
