FactoryGirl.define do
  factory :feed_favorite do
    trait :with_user do
      user
    end

    trait :with_feed do
      feed
    end

    factory :invalid_feed_favorite do
      user nil
      feed { create(:feed, :with_user) }
    end
  end
end
