class Feed < ApplicationRecord
  enum privacy: { public_feed: 0, follower_only_feed: 1, private_feed: 2 }
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  validates :privacy, presence: true
end
