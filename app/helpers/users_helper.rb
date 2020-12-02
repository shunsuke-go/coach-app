module UsersHelper
  
  def num_point(reviews)
    point = 0
     reviews.each do |review|
       point += review.rate
     end
     @point = point / reviews.count
  end

end
