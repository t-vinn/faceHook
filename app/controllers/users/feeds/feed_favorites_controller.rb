# rubocop: disable Metrics/AbcSize
module Users
  module Feeds
    class FeedFavoritesController < BaseController
      def create
        feed = Feed.find(params[:feed_id])
        if feed.repliable_by?(current_user) && feed.user != current_user
          feed_favorite = current_user.feed_favorites.build(feed_id: params[:feed_id])
          if feed_favorite.save
            UserMailer.feed_favorite_creation(feed_favorite).deliver_later
            redirect_to params[:path], notice: 'You liked a feed!'
          else
            redirect_to params[:path], notice: 'FAIL. Try again.'
          end
        else
          render_404
        end
      end

      def destroy
        if FeedFavorite.find(params[:id]).destroy
          redirect_to params[:path], notice: 'Your favorite deleted.'
        else
          flash.now[:notice] = 'An error occured and faceHook failed to delete your follow.'
        end
      end
    end
  end
end
