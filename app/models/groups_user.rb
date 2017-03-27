class GroupsUser < ApplicationRecord
  belongs_to :group, inverse_of: :groups_users
  belongs_to :user
  validates :group, presence: true, uniqueness: { scope: [:user_id] }
  validates :user_id, presence: true
end
