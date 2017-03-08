class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates :user_id, presence: true
  validates :feed_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  has_many :reply_favorites
  has_many :reply_pictures, inverse_of: :reply
  accepts_nested_attributes_for :reply_pictures

  def related_users
    User.find(feed.replies.pluck(:user_id)).push(feed.user)
  end
end
