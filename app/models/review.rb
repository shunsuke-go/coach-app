class Review < ApplicationRecord
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewed, class_name: 'User'
  validates :content, presence: true, length: { maximum: 300 }
  validates :rate, presence: true, numericality:
  { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
