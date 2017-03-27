class SimilaritiesUser < ApplicationRecord
  validates :similarity_id, presence: true, uniqueness: { scope: [:user_id] }
  validates :user_id, presence: true
  belongs_to :similarity
end
