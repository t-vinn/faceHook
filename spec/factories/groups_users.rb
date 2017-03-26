FactoryGirl.define do
  factory :groups_user do
    group_id 20
    sequence(:user_id) { |n| n }
  end
end
