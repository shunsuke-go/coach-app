class Profile < ApplicationRecord
  belongs_to :user
  validates :age, numericality: { less_than_or_equal_to: 120 }, allow_nil: true
  validates :content,  length: { maximum: 1000 }
  validates :address,  length: { maximum: 10 }
  validates :wages, numericality: { less_than_or_equal_to: 100_000 }, allow_nil: true
  validates :favorite, length: { maximum: 20 }
end
