class FeedPicture < ApplicationRecord
  belongs_to :feed
  mount_uploader :picture, PictureUploader
  validates :feed_id, presence: true
  validates :picture, presence: true
  validate :picture_size

  private

    # validate uploaded picture size
    def picture_size
      errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
    end
end
