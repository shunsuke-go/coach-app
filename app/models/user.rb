class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

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

   def forget
    update_attribute(:remember_digest,nil)
   end



  private

  def downcase_email
    self.email = email.downcase
  end
end
