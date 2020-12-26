class Profile < ApplicationRecord
  belongs_to :user  
  validates :age, numericality: true, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  validates :address, presence: true, length: { maximum: 50 }
end
