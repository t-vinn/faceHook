require 'rails_helper'

RSpec.describe GroupPost do
  let(:group_post) { build(:group_post) }

  let(:invalid_group_post) { build(:invalid_group_post) }
  it 'is valid with a user_id, content, and group_id' do
    expect(group_post).to be_valid
  end

  it 'is invalid without content' do
    invalid_group_post.valid?
    expect(invalid_group_post.errors[:content]).to include("can't be blank")
  end
end
