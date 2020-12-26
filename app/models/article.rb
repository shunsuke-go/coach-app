class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
  has_one :map, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'そのファイル形式は使用できません' },
                    size: { less_than: 5.megabytes,
                            message: '5MB以下の画像を使用してください' }

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
