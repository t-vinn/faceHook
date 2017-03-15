# rubocop: disable Metrics/AbcSize
module Users
  module Feeds
    class FeedFavoritesController < BaseController
      def create
        feed = Feed.find(params[:feed_id])
        if feed.not_repliable_by_current_user(current_user) || feed.user == current_user
          render file: 'public/404.html', status: :not_found, layout: false
        else
          feed_favorite = current_user.feed_favorites.build(feed_id: params[:feed_id])
          if feed_favorite.save
            UserMailer.feed_favorite_creation(feed_favorite).deliver_later
            redirect_to root_path, notice: 'You liked a feed!'
          else
            redirect_to root_path, notice: 'FAIL. Try again.'
          end
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
