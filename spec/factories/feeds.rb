FactoryGirl.define do
  factory :feed do
    user_id 300
    content 'hhhhhhhfirjf'
    privacy 'share_with_all'

    factory :invalid_feed do
      content nil
    end
  end
end
