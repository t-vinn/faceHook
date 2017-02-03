class FollowRelationship < ApplicationRecord
  belongs_to :user
  validates :follower_user_id, presence: true
  validates :followee_user_id, presence: true
end
