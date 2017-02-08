class Feed < ApplicationRecord
  enum privacy: { public: 0, follower_only: 1, private: 2 }
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  validates :privacy, presence: true
end
