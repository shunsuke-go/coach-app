class Article < ApplicationRecord
  belongs_to :user
  mount_uploader :thumbnail, ThumbnailUploader

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
  has_one :map, dependent: :destroy
  has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 50 }

  acts_as_taggable
  has_rich_text :content

  # 通知作成　いいね
  def create_like_notification(current_user)
    like_notification = current_user.active_notifications.build(
      article_id: id,
      visited_id: user_id,
      action: 'like'
    )

    like_notification.save if like_notification.valid?
  end

  # 通知作成　コメント
  def create_comment_notification(current_user, comment)
    comment_notification = current_user.active_notifications.build(
      article_id: id,
      visited_id: user_id,
      comment_id: comment.id,
      action: 'comment'
    )
    comment_notification.save if comment_notification.valid?
  end

  # 画像のリサイズ
  def display_image
    image.variant(resize_to_limit: [200, 200])
  end
end
