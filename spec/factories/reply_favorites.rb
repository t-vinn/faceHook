FactoryGirl.define do
  factory :reply_favorite do
    reply
    trait :with_user do
      user { create(:user, :with_password) }
    end
  end
end
