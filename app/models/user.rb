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
  has_many :following_users, through: :active_relationships,
                             source: :followee_user, dependent: :destroy
  has_many :follower_users, through: :passive_relationships,
                            source: :follower_user, dependent: :destroy
  has_many :feeds, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :feed_favorites, dependent: :destroy
  has_many :reply_favorites, dependent: :destroy
  has_many :groups, through: :groups_users, dependent: :destroy
  has_many :groups_users, dependent: :destroy
  has_many :group_posts, dependent: :destroy
  has_many :group_post_favorites, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validate :picture_size

  def mutual_followers
    following_users & follower_users
  end

  private

    # validate uploaded picture size
    def picture_size
      errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
    end
end
