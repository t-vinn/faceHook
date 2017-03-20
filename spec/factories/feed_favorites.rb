FactoryGirl.define do
  factory :feed_favorite do
    trait :with_user do
      user
    end

    trait :with_feed do
      feed
    end

    trait :invalid do
      user_id nil
    end
  end
end
