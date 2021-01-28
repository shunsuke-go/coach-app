class Profile < ApplicationRecord
  belongs_to :user
  validates :age, numericality: true, allow_nil: true
  validates :content,  length: { maximum: 1000 }
  validates :address,  length: { maximum: 50 }
  validates :wages, numericality: true, allow_nil: true
  validates :favorite, length: { maximum: 50 }
end
