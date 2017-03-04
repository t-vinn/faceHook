module Users
  module Feeds
    class FeedFavoritesController < BaseController
      def create
        feed_favorite = current_user.feed_favorites.build(feed_id: params[:feed_id])
        if feed_favorite.save
          redirect_to root_path, notice: 'You liked a feed!'
        else
          redirect_to root_path, notice: 'FAIL. Try again.'
        end
      end

      def destroy
        if FeedFavorite.find(params[:id]).destroy
          redirect_to root_path, notice: 'Your favorite deleted.'
        else
          flash.now[:notice] = 'An error occured and faceHook failed to delete your follow.'
        end
      end
    end
  end
end
