FactoryGirl.define do
  factory :reply do
    user { create(:user, :with_password) }
    feed { create(:feed, :with_user) }
    content 'hhhhhhhfirjf'

    factory :invalid_reply do
      content nil
    end
  end
end
