class GroupsUser < ApplicationRecord
  belongs_to :group, inverse_of: :groups_users
  belongs_to :user
  validates :group, presence: true
  validates :user_id, presence: true
end
