class Feed < ApplicationRecord
  enum privacy: { share_with_all: 0, share_with_follower: 1, share_with_only_me: 2 }
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  validates :privacy, presence: true
  has_many :replies, dependent: :destroy
  has_many :feed_favorites, dependent: :destroy
  has_many :feed_pictures, inverse_of: :feed, dependent: :destroy
  accepts_nested_attributes_for :feed_pictures, allow_destroy: true, reject_if: :all_blank

  def not_repliable_by_current_user(current_user)
    privacy == 'share_with_only_me' || \
      privacy == 'share_with_follower' && current_user.following_users.exclude?(user)
  end
end
