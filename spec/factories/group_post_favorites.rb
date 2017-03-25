FactoryGirl.define do
  factory :group_post_favorite do
    user { create(:user, :with_password) }
    group_post { create(:group_post) }

    factory :invalid_group_post_favorite do
      user nil
    end
  end
end
