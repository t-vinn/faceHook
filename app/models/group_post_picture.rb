class GroupPostPicture < ApplicationRecord
  belongs_to :group_post
  mount_uploader :picture, PictureUploader
  validates :group_post, presence: true
  validates :picture, presence: true
  validate :picture_size

  private

    # validate uploaded picture size
    def picture_size
      errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
    end
end
