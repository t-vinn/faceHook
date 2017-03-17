FactoryGirl.define do
  factory :group do
    owner_user_id 300
    sequece(:name) { |n| "group-#{n}" }

    factory :invalid_group do
      owner_user_id nil
    end
  end
end
