class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope -> {order(created_at: :desc)} 
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:500}
  validates :title, presence: true, length: {maximum:20}
end
