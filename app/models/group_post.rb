class GroupPost < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  has_many :group_post_favorites
end
