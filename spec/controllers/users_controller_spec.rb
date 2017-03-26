require 'rails_helper'

RSpec.describe Users::UsersController, type: :controller do
  login_user

  describe 'GET #index' do
    let(:users) { create_list(:user, 2, :with_password) }
    let!(:follow_relationship_1) { create(:follow_relationship, follower_user: controller.current_user, followee_user: users[0]) }
    let!(:follow_relationship_2) { create(:follow_relationship, follower_user: users[1], followee_user: users[0]) }
    let!(:feed) { create(:feed, user: users[1]) }
    let!(:feeds) { create_list(:feed, 2, user: users[0]) }
    let!(:group_posts) { create_list(:group_post, 2, user: users[0]) }
    let!(:group_post_fav_1) { controller.current_user.group_post_favorites.create(group_post: group_posts[0]) }
    let!(:group_post_fav_2) { controller.current_user.group_post_favorites.create(group_post: group_posts[1]) }
    subject { get :index, params: { id: users[0] } }

    it 'assigns the requested users to @following_users' do
      subject
      expect(assigns(:following_users)).to match_array([users[0]])
    end

    it 'assigns the requested users to @unfollowing_users' do
      subject
      expect(assigns(:unfollowing_users)).to match_array([users[1]])
    end

    it 'assigns the requested active_relationships to @follow_relationships_index_by_followee_user_id' do
      subject
      expect(assigns(:follow_relationships_index_by_followee_user_id)).to match_array([[users[0].id, follow_relationship_1]])
    end

    it 'assigns the requested feed to @feed' do
      subject
      expect(assigns(:feed)).to be_a_new(Feed)
    end

    it 'assigns the requested feeds or group_posts to @posts' do
      subject
      expect(assigns(:posts)).to match_array([feed, feeds[0], feeds[1]])
    end

    it 'assigns the requested feeds or group_posts to @following_feeds_or_group_posts' do
      subject
      expect(assigns(:following_posts)).to match_array([feeds[0], feeds[1]])
    end

    it 'assigns the requested group_post_favorites to @group_post_favorites_index_by_feed_id' do
      subject
      expect(assigns(:group_post_favorites_index_by_group_post_id)).to match_array([[group_post_fav_1.group_post_id, group_post_fav_1], [group_post_fav_2.group_post_id, group_post_fav_2]])
    end

    it 'returns 200' do
      is_expected.to have_http_status 200
    end

    it 'renders the :index template' do
      is_expected.to render_template :index
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
