require 'rails_helper'

RSpec.describe Users::UsersController, type: :controller do
  login_user

  describe 'GET #index' do
    it 'assigns the requested users to @following_users' do
    end

    it 'assigns the requested users to @unfollowing_users' do
    end

    it 'assigns the requested active_relationships to @follow_relationships_index_by_followee_user_id' do
    end

    it 'assigns the requested feed to @feed' do
      feed = create(:feed)
    end

    it 'assigns the requested feeds or group_posts to @posts' do
    end

    it 'assigns the requested feeds or group_posts to @following_feeds_or_group_posts' do
    end

    it 'assigns the requested feed_favorites to @feed_favorites_index_by_feed_id' do
      feed_favorites_index_by_feed_id = create(:feed_favorites_index_by_feed_id)
      get :show, id: controller.user
      expect(assigns(:feed_favorites_index_by_feed_id)).to eq feed_favorites_index_by_feed_id
    end

    it 'assigns the requested reply_favorites to @reply_favorites_index_by_reply_id' do
      reply_favorites_index_by_reply_id = create(:reply_favorites_index_by_reply_id)
      get :show, id: controller.user
      expect(assigns(:reply_favorites_index_by_reply_id)).to eq reply_favorites_index_by_reply_id
    end

    it 'assigns the requested group_post_favorites to @group_post_favorites_index_by_group_post_id' do
      group_post_favorites_index_by_group_post_id = create(:group_post_favorites_index_by_group_post_id)
      get :show, id: user
      expect(assigns(:group_post_favorites_index_by_group_post_id)).to eq group_post_favorites_index_by_group_post_id
    end

    it 'renders the :index template' do
      get :index, id: user
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user, :with_password) }
    let(:feeds) { create_list(:feed, 2, user: user) }
    let!(:feed_fav_1) { controller.current_user.feed_favorites.create(feed: feeds[0]) }
    let!(:feed_fav_2) { controller.current_user.feed_favorites.create(feed: feeds[1]) }
    let!(:rep_fav_1) { controller.current_user.reply_favorites.create(reply_id: 10) }
    let!(:rep_fav_2) { controller.current_user.reply_favorites.create(reply_id: 19) }
    subject { get :show, params: { id: user } }

    it 'assigns the requested user to @user' do
      subject
      expect(assigns(:user)).to eq user
    end

    it 'assigns the requested feeds to @feeds' do
      subject
      expect(assigns(:feeds)).to match_array feeds
    end

    it 'assigns the requested feed_favorites to @feed_favorites_index_by_feed_id' do
      subject
      expect(assigns(:feed_favorites_index_by_feed_id)).to match_array([[feed_fav_1.feed_id, feed_fav_1], [feed_fav_2.feed_id, feed_fav_2]])
    end

    it 'assigns the requested reply_favorites to @reply_favorites_index_by_reply_id' do
      subject
      expect(assigns(:reply_favorites_index_by_reply_id)).to match_array([[rep_fav_1.reply_id, rep_fav_1], [rep_fav_2.reply_id, rep_fav_2]])
    end

    it 'returns 200' do
      is_expected.to have_http_status 200
    end

    it 'renders the :show template' do
      is_expected.to render_template :show
    end
  end
end
