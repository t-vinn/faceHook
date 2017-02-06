class FollowRelationship < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :followee_user, class_name: 'User'
  validates :follower_user_id, presence: true
  validates :followee_user_id, presence: true

end
