require 'rails_helper'

RSpec.describe Users::Feeds::FeedFavoritesController, type: :controller do
  login_user

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:feed) { create(:feed) }

      it 'returns 302' do
        post :create, params: { feed_id: feed, feed_favorite: attributes_for(:feed_favorite) }
        expect(response.status).to eq 302
      end

      it 'adds a feed_favorite to the database' do
        expect{
          post :create, params: { feed_id: feed, feed_favorite: attributes_for(:feed_favorite) }
        }.to change(FeedFavorite, :count).by(1)
      end

      it 'redirects to root path' do
        post :create, params: { feed_id: feed, feed_favorite: attributes_for(:feed_favorite) }
        expect(response).to redirect_to root_path
      end

    end

    context 'with invalid parameters' do
      let(:feed) { create(:feed) }
      
      it 'returns 302' do
        post :create, params: { feed_id: feed, feed_favorite: attributes_for(:feed_favorite) }
        expect(response.status).to eq 302
      end

      it 'does not add a feed_favorite to the database' do
        expect do
          post :create, params: { feed_id: feed, feed_favorite: attributes_for(:feed_favorite, :invalid) }
        end.not_to change(FeedFavorite, :count)
      end

      it 'redirects to root path' do
        post :create, params: { feed_id: feed, feed_favorite: attributes_for(:feed_favorite, :invalid) }
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'DELETE #destroy' do
    let!(:feed_favorite) { create(:feed_favorite, :with_feed, :with_user) }

    it 'deletes the feed_favorite' do
      expect do
        delete :destroy, params: { feed_id: feed_favorite.feed, id: feed_favorite }
      end.to change(FeedFavorite, :count).by(-1)
    end

    it 'redirects to root path' do
      delete :destroy, params: { feed_id: feed_favorite.feed, id: feed_favorite }
      expect(response).to redirect_to root_path
    end

    it 'returns 302' do
      delete :destroy, params: { feed_id: feed_favorite.feed, id: feed_favorite }
      expect(response.status).to eq 302
    end

  end
end
