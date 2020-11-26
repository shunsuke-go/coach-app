class Profile < ApplicationRecord
  belongs_to :user
  
  validates :age, numericality: true, presence: true
  validates :content, presence: true
  validates :address, presence: true
end
