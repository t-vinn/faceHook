class ReplyFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :reply
  validates :user_id, presence: true, uniqueness: { scope: [:reply_id] }
  validates :reply_id, presence: true

  def related_users
    [user, reply.user]
  end
end
