FactoryGirl.define do
  factory :group_post do
    user { create(:user, :with_password) }
    group_id 1
    sequence(:content) { |n| "group post content-#{n}" }

    factory :invalid_group_post do
      content nil
    end
  end
end
