class GroupPost < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  has_many :group_post_favorites
  has_many :group_post_pictures, inverse_of: :group_post
  accepts_nested_attributes_for :group_post_pictures, allow_destroy: true, reject_if: :all_blank
end
