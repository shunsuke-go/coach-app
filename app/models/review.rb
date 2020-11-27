class Review < ApplicationRecord
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewed, class_name: "User"
  validates :content, presence: true
  validates :rate,presence: true, numericality: true 




  

def num_point(reviews)
   point = 0
    reviews.each do |review|
      point += review.rate
    end
    @point = point / reviews.count
end



end
