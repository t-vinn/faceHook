class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :owner_user_id, presence: true
  has_many :users, through: :groups_users
end
