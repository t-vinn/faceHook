class Group < ApplicationRecord
  validates :name, presence: true
  has_many :users, through: :groups_users
end
