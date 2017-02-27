class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :owner_user_id, presence: true
  has_many :groups_users, inverse_of: :group
  has_many :users, through: :groups_users
  accepts_nested_attributes_for :groups_users

  def owner_user
    User.find(self.owner_user_id)
  end
end
