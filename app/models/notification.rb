class Notification < ApplicationRecord
  belongs_to :article, optional: true
  belongs_to :message, optional: true
  belongs_to :comment, optional: true
  belongs_to :visiter, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
  default_scope -> { order(created_at: :desc) }
  validates :action, inclusion: { in: %w[like comment message follow review] }
end
