class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates :user_id, presence: true
  validates :feed_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  has_many :reply_favorites
end
