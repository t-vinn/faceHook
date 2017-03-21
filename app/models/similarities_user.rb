class SimilaritiesUser < ApplicationRecord
  validates :similarity_id, presence: true
  validates :user_id, presence: true
  belongs_to :similarity
end
