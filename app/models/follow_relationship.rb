class FollowRelationship < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :followee_user, class_name: 'User'
  validates :follower_user_id, presence: true
  validates :followee_user_id, presence: true
  validate :cant_follow_yourself

private

  def cant_follow_yourself
    if followee_user_id == follower_user_id
      errors.add(:followee_user_id, "can't follow yourself")
    end
  end

end
