FactoryGirl.define do
  factory :feed do
    content 'hhhhhhhfirjf'
    privacy 'share_with_all'
    trait :with_user do
      user
    end

    factory :invalid_feed do
      content nil
    end
  end
end
