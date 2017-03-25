FactoryGirl.define do
  factory :follow_relationship do
    follower_user { create(:user, :with_password) }
    followee_user { create(:another_user) }

    factory :invalid_follow_relationship do
      follower_user nil
    end
  end
end
