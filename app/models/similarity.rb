class Similarity < ApplicationRecord
  validates :similarity, presence: true
  has_many :similarities_users, dependent: :destroy
end
