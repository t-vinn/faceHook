require 'rails_helper'

RSpec.describe ReplyFavorite do
  let(:reply_favorite) { build(:reply_favorite, :with_user) }
  let(:invalid_reply_favorite) { build(:reply_favorite) }

  it 'is valid with a name, email, and password' do
    expect(reply_favorite).to be_valid
  end

  it 'is invalid without a user_id' do
    invalid_reply_favorite.valid?
    expect(invalid_reply_favorite.errors[:user_id]).to include("can't be blank")
  end

  it 'returns related_users as an array' do
    expect(reply_favorite.related_users).to match_array([reply_favorite.user, reply_favorite.reply.user])
  end
end
