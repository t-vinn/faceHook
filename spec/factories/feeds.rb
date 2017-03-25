FactoryGirl.define do
  factory :feed do
    content 'hhhhhhhfirjf'
    privacy 'share_with_all'
    trait :with_user do
      user { create(:user, :with_password) }
    end

    factory :invalid_feed do
      content nil
      privacy nil
    end

    factory :too_long_feed do
      content 'rijrfrjfijwojrefiklwemcomeocdksmlfsnlkmcdsklfjmelrksdjcoweijrkfmlksmclekjfsmslkclsmrwoqrfjqwiorjoiwjoqijfqjprjoijjrfiwjksdljznmxkljfkjlejritjpirejlkfsdmxkjesorjfiorwehgihwperohgjiprtohgpowihgpiwhgiohowehgiwojghwiopghwpogijfkdsmlkxz'
      user_id 10
    end
  end
end
