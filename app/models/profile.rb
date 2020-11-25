class Profile < ApplicationRecord
  belongs_to :user
  
  validates :age, numericality: true
  validates :content, presence: true
end
