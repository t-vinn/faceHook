require 'rails_helper'

RSpec.describe GroupPostFavorite do
  let(:group_post_favorite) { build(:group_post_favorite) }

  let(:invalid_group_post_favorite) { build(:invalid_group_post_favorite) }

  it 'is valid with user_id, group_post_id' do
    expect(group_post_favorite).to be_valid
  end

  it 'is invalid without a user_id' do
    invalid_group_post_favorite.valid?
    expect(invalid_group_post_favorite.errors[:user_id]).to include("can't be blank")
  end

  it 'returns related_users as an array' do
    expect(group_post_favorite.related_users).to match_array([group_post_favorite.user, group_post_favorite.group_post.user])
  end
end
