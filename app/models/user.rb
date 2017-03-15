# rubocop: disable AbcSize
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include ApplicationHelper
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :notification_allowed, inclusion: { in: [true, false] }

  has_many :active_relationships,
           class_name: 'FollowRelationship',
           foreign_key: 'follower_user_id',
           dependent: :destroy
  has_many :passive_relationships,
           class_name: 'FollowRelationship',
           foreign_key: 'followee_user_id', dependent: :destroy
  has_many :following_users, through: :active_relationships, source: :followee_user
  has_many :follower_users, through: :passive_relationships, source: :follower_user
  has_many :feeds, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :feed_favorites, dependent: :destroy
  has_many :reply_favorites, dependent: :destroy
  has_many :groups, through: :groups_users
  has_many :groups_users
  has_many :group_posts
  has_many :group_post_favorites
  mount_uploader :picture, PictureUploader
  validate :picture_size
  scope :notifiable, -> { where(notification_allowed: true) }

  def mutual_followers
    following_users & follower_users
  end

  def recommended_user_ids
    user_ids = User.all.ids - [id]
    similarities = {}
    user_ids.each do |ui|
      similarities[ui] = cos_similarity(id, ui)
      # REDIS.zadd 'similarities', cos_similarity(id, ui), ui
    end
    sorted = Hash[similarities.sort_by { |_k, v| -v }]
    top_ten = Hash[*sorted.to_a.shift(10).flatten!]
    top_ten.keys
    # REDIS.zrevrangebyscore 'similarities', 1, 0, limit: [0, 10]
  end

  def self.redis
    @redis ||= Redis.new
  end

  private

    # validate uploaded picture size
    def picture_size
      errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
    end
end
