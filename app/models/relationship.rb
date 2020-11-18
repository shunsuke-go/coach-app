class Relationship < ApplicationRecord

  # followed,followerというUserクラスを元にした
  # 架空のモデルと繋がっている事を示す
  
  belongs_to :followed,class_name: "User"
  belongs_to :follower, class_name: "User"
  validates :follower_id,presence: true
  validates :followed_id,presence: true

end
