FactoryBot.define do
  factory :comment do
    user { nil }
    article { nil }
    content { "MyString" }
  end
end
