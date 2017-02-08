class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :active_relationships,
           class_name: 'FollowRelationship',
           foreign_key: 'follower_user_id',
           dependent: :destroy
  has_many :passive_relationships,
           class_name: 'FollowRelationship',
           foreign_key: 'followee_user_id', dependent: :destroy
  has_many :following_users, through: :active_relationships, source: :followee_user
  has_many :follower_users, through: :passive_relationships, source: :follower_user
  has_many :feeds
end
