require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user, :with_password) }
  it 'is valid with a name, email, and password' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    invalid_user = build(:user)
    invalid_user.valid?
    expect(invalid_user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    create(:another_user, :same_email)
    user_1 = build(:another_user, :same_email)
    user_1.valid?
    expect(user_1.errors[:email]).to include('has already been taken')
  end

  it 'returns mutual_followers as an array' do
    user_1 = create(:user, :with_password)
    user_2 = create(:user, :with_password)
    FollowRelationship.create(follower_user_id: 1, followee_user_id: 2)
    FollowRelationship.create(follower_user_id: 2, followee_user_id: 1)
    expect(user_1.mutual_followers).to match_array([user_2])
  end
end
