class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :content, presence: true, length: { maximum: 150 }

  def create_message_notification(user)
    message_notification = user.passive_notifications.build(
      visiter_id: user_id,
      message_id: id,
      action: 'message'
    )
    message_notification.save if message_notification.valid?
  end
end
