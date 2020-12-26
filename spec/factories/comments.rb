FactoryBot.define do
  factory :comment do
    association :article
    user { article.user }
    content { "a" * 100 }
  end
end
