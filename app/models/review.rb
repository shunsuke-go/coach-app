class Review < ApplicationRecord
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewed, class_name: "User"
  validates :content, presence: true
  validates :rate,presence: true, numericality: true 




  





end
