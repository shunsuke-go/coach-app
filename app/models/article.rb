class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes,source: :user
  has_many :notifications,dependent: :destroy

  default_scope -> {order(created_at: :desc)} 
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:500}
  validates :title, presence: true, length: {maximum:20}


  def create_like_notification(current_user)
    like_notification = current_user.active_notifications.build(
        article_id: id,
        visited_id: user_id,
        action:"like"
    )
  
    like_notification.save if like_notification.valid?
  end

  def  create_comment_notification(current_user,comment)
    comment_notification = current_user.active_notifications.build(
    article_id: id,
    visited_id: user_id,
    comment_id: comment.id,
    action: "comment"
      
      
  ) 

    comment_notification.save if comment_notification.valid?
    
      
  end

end
