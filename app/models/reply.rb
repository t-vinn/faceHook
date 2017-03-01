class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :feed_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  has_many :reply_favorites
  validate :picture_size

  private

    # validate uploaded picture size
    def picture_size
      errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
    end

end
