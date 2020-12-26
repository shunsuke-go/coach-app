module UsersHelper
  def num_point(reviews)
    return 0 if reviews.count == 0

    point = 0
    reviews.each do |review|
      point += review.rate
    end
    @point = point / reviews.count
  end
end
