module ArticlesHelper
  def like?(user)
    likes.include?(user)
  end
end
