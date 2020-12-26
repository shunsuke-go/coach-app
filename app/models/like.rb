class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :user_id, presence: true, uniqueness: { scope: :article_id }
  validates :article_id, presence: true
end
