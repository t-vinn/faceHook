FactoryGirl.define do
  factory :reply do
    user_id 300
    feed_id 1
    content 'hhhhhhhfirjf'

    factory :invalid_reply do
      content nil
    end
  end
end
