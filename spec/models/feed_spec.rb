require 'rails_helper'

RSpec.describe Feed do
  let(:feed) { build(:feed, :with_user) }
  it 'is valid with a content, privacy, and user_id' do
    expect(feed).to be_valid
  end

  it 'is invalid without a content' do
    invalid_feed = build(:invalid_feed)
    invalid_feed.valid?
    expect(invalid_feed.errors[:content]).to include("can't be blank")
  end
  
  it 'is invalid without user_id' do
    invalid_feed = build(:invalid_feed)
    invalid_feed.valid?
    expect(invalid_feed.errors[:user_id]).to include("can't be blank")
  end

  it 'is invalid without privacy' do
    invalid_feed = build(:invalid_feed)
    invalid_feed.valid?
    expect(invalid_feed.errors[:privacy]).to include("can't be blank")
  end

  it 'is invalid with content too long' do
    too_long_feed = build(:too_long_feed)
    too_long_feed.valid?
    expect(too_long_feed.errors[:content]).to include("too long")
  end
end
