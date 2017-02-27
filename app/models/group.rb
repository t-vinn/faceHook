class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :owner_user_id, presence: true
  has_many :groups_users, inverse_of: :group
  has_many :users, through: :groups_users
  accepts_nested_attributes_for :groups_users

  def owner_user
    User.find(owner_user_id)
  end

  def invitable_users
    invited_users = User.find(groups_users.pluck(:user_id))
    owner_user.mutual_followers - invited_users
  end
end
