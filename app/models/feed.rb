class Feed < ApplicationRecord
  enum privacy: { share_with_all: 0, share_with_follower: 1, share_with_only_me: 2 }
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  validates :privacy, presence: true
  has_many :replies
  has_many :feeds_favorites
end
