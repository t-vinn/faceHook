class Feed < ApplicationRecord
  enum privacy: { share_with_all: 0, share_with_follower: 1, share_with_only_me: 2 }
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  validates :privacy, presence: true
  has_many :replies
  has_many :feed_favorites
  validate :picture_size

  private

    # validate uploaded picture size
    def picture_size
      errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
    end
end
