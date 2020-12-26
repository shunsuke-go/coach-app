FactoryBot.define do
  factory :like do
    association :article
    user { article.user }
  end
end
