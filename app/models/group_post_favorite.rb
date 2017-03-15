class GroupPostFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :group_post
  validates :user_id, presence: true, uniqueness: { scope: [:group_post_id] }
  validates :group_post_id, presence: true

  def related_users
    [user, group_post.user]
  end
end
