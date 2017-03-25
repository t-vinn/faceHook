require 'rails_helper'

RSpec.describe FollowRelationship do
  let(:follow_relationship) { build(:follow_relationship) }

  let(:invalid_follow_relationship) { build(:invalid_follow_relationship) }

  it 'is valid with follower_user_id, and followee_user_id' do
    expect(follow_relationship).to be_valid
  end

  it 'is invalid without follower_user_id' do
    invalid_follow_relationship.valid?
    expect(invalid_follow_relationship.errors[:follower_user_id]).to include("can't be blank")
  end

  it 'returns nil if follower != followee' do
    expect(follow_relationship.send(:check_follow_yourself)).to be nil
  end
end
