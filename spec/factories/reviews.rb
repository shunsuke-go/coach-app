FactoryBot.define do
  factory :review do
    content { 'a' * 300 }
    rate { 3 }
  end
end
