class FeedFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates :user_id, presence: true, uniqueness: { scope: :feed_id }
  validates :feed_id, presence: true
end
