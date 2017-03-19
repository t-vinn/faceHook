FactoryGirl.define do
  factory :feed_favorite do
    factory :invalid_feed_favorite do
      user_id nil
    end

    trait :with_user do
      user
    end

    trait :with_feed do
      feed
    end

  end

end
