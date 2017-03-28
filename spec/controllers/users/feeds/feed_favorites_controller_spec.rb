require 'rails_helper'

RSpec.describe Users::Feeds::FeedFavoritesController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      login_user
      let(:feed) { create(:feed, :with_user) }
      let(:feed_favorite) { controller.current_user.feed_favorites.build(feed: feed) }
      let(:feed_favorite_params) do
        { user_id: feed_favorite.user_id, feed_id: feed_favorite.feed_id }
      end
      subject do
        post :create,
             params: { feed_id: feed_favorite.feed, feed_favorite: feed_favorite_params, path: root_path }
      end

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
    end
  end

  describe 'DELETE #destroy' do
    login_user
    let!(:feed) { create(:feed, :with_user) }
    let!(:feed_favorite) { controller.current_user.feed_favorites.create(feed: feed) }
    subject { delete :destroy, params: { feed_id: feed_favorite.feed, id: feed_favorite, path: root_path } }

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
