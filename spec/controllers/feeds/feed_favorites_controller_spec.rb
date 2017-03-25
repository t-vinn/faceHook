require 'rails_helper'

RSpec.describe Users::Feeds::FeedFavoritesController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      login_user
      let(:feed) { create(:feed, :with_user) }
      let(:feed_favorite) { controller.current_user.feed_favorites.build(feed: feed) }
      let(:feed_favorite_params) { { user_id: feed_favorite.user_id, feed_id: feed_favorite.feed_id } }
      subject { post :create, params: { feed_id: feed_favorite.feed, feed_favorite: feed_favorite_params } }

      it 'returns 302' do
        is_expected.to have_http_status(302)
      end

      it 'adds a feed_favorite to the database' do
        expect { subject }.to change(FeedFavorite, :count).by(1)
      end

      it 'redirects to root path' do
        is_expected.to redirect_to root_path
      end
    end

    context 'with invalid parameters' do
      login_user
      let(:feed) { create(:feed, :with_user) }
      let(:invalid_feed_favorite_params) { { feed_id: feed.id, user_id: nil } }

      subject { post :create, params: { feed_id: feed.id, feed_favorite_params: invalid_feed_favorite_params } }

      it 'returns 302' do
        is_expected.to have_http_status 302
      end

      it 'does not add a feed_favorite to the database' do
        expect { subject }.not_to change(FeedFavorite, :count)
      end

      it 'redirects to root path' do
        is_expected.to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    login_user
    let!(:feed) { create(:feed, :with_user) }
    let!(:feed_favorite) { controller.current_user.feed_favorites.create(feed: feed) }
    subject { delete :destroy, params: { feed_id: feed_favorite.feed, id: feed_favorite } }

    it 'deletes the feed_favorite' do
      expect { subject }.to change(FeedFavorite, :count).by(-1)
    end

    it 'redirects to root path' do
      is_expected.to redirect_to root_path
    end

    it 'returns 302' do
      is_expected.to have_http_status 302
    end
  end
end
