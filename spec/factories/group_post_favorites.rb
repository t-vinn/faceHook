FactoryGirl.define do
  factory :group_post_favorite do
    user_id 20
    sequence(:group_post_id) { |n| n.to_s.to_i }
  end
end
