class User < ApplicationRecord
  
  has_many :articles, dependent: :destroy

  # active_relationships関連付けはRelationshipクラスを元にして
  # follower_idを参照する。
  # passiveはその逆。

  has_many :active_relationships,
            class_name: "Relationship",
            foreign_key: "follower_id",
            dependent: :destroy

  has_many :passive_relationships,
            class_name: "Relationship",
            foreign_key: "followed_id",
            dependent: :destroy
  
  # following　followerという架空のモデルはactive,passive関連付け
  # を通過する（それぞれのidを外部キーとして参照する）。
  
  has_many :following, through: :active_relationships,
   source: :followed
  has_many :followers, through: :passive_relationships,
   source: :follower
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 },allow_nil: true

   # 渡された文字列のハッシュ値を返す
   def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
   end

  #ランダムなトークンを作成し、リターンする
   def User.new_token
    SecureRandom.urlsafe_base64
   end 

   #remember_tokenにランダム文字列を代入しそれを暗号化したものを
   #remember_digestに保存する
   def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
   end

   #remember_tokenとremember_digestのハッシュ前の値が同じかどうか確認
   def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
   end

   #cookieのremember_digestを空にする
   def forget
    update_attribute(:remember_digest,nil)
   end

   def feed
    Article.where("user_id = ?", self.id)
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

   





  private

  def downcase_email
    self.email = email.downcase
  end
end
