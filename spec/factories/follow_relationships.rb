FactoryGirl.define do
  factory :follow_relationship do
    follower_user_id 20
    sequence(:followee_user_id) { |n| n}
  end
end
