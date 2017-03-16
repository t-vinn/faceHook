FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    sequence(:name) { |n| "ENgineer-#{n}" }
    password 'hhhhhhh'
  end
end
