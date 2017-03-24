FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    sequence(:name) { |n| "ENgineer-#{n}" }
    trait :with_password do
      password 'hhhhhhh'
    end
  end
  factory :another_user, class: User do
    sequence(:name) { |n| "ENgineer-#{n}" }
    email 'hoge@mail.cm'
    password 'hhhhhergerj'
  end
end
