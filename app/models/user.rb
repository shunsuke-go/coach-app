class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :articles, dependent: :destroy
  has_many :active_relationships,
           class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy

  has_many :passive_relationships,
           class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy

  has_many :following, through: :active_relationships,
                       source: :followed
  has_many :followers, through: :passive_relationships,
                       source: :follower

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification',
                                  foreign_key: 'visiter_id', dependent: :destroy

  has_many :passive_notifications, class_name: 'Notification',
                                   foreign_key: 'visited_id', dependent: :destroy

  has_one :profile, dependent: :destroy

  has_many :active_reviews, class_name: 'Review',
                            foreign_key: 'reviewer_id', dependent: :destroy

  has_many :passive_reviews, class_name: 'Review',
                             foreign_key: 'reviewed_id', dependent: :destroy

  has_many :reviewing, through: :active_reviews,
                       source: :reviewed

  has_many :reviewers, through: :passive_reviews,
                       source: :reviewer

  has_secure_token :token
  attr_accessor :remember_token

  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 },
                       allow_nil: true

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    followed_ids = "SELECT followed_id FROM relationships
    WHERE follower_id = :user_id"
    Article.where("user_id IN (#{followed_ids})
    OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def article_like?(article)
    likes.exists?(article_id: article.id)
  end

  def create_follow_notification(current_user, other_user)
    notification = current_user.active_notifications.build(
      visited_id: other_user.id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end

  def create_review_notification(current_user, reviewed_user)
    notification = current_user.active_notifications.build(
      visited_id: reviewed_user.id,
      action: 'review'
    )
    notification.save if notification.valid?
  end

  def users_room(current_user)
    if id != current_user.id
      Room.find_by_sql("SELECT * FROM rooms WHERE id IN
    (SELECT room_id FROM entries WHERE user_id = #{id} &&
    room_id IN (SELECT room_id FROM entries WHERE user_id = #{current_user.id}))")

    end
  end

  def guest?(user)
    id == user.id
  end

  private

    def downcase_email
      self.email = email.downcase
    end
end
