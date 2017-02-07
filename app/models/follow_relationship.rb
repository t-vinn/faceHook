class FollowRelationship < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :followee_user, class_name: 'User'
  validates :follower_user_id, presence: true
  validates :followee_user_id, presence: true
  validate :check_follow_yourself

  private

    def check_follow_yourself
      return unless followee_user_id == follower_user_id
      errors.add(:followee_user_id, "can't follow yourself")
    end
end
