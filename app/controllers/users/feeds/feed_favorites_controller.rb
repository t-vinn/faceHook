# rubocop: disable Metrics/AbcSize
module Users
  module Feeds
    class FeedFavoritesController < BaseController
      def create
        feed = Feed.find(params[:feed_id])
        unless feed.privacy == 'share_with_only_me' ||
               feed.privacy == 'share_with_follower' &&
               current_user.following_users.exclude?(feed.user)
          feed_favorite = current_user.feed_favorites.build(feed_id: params[:feed_id])
          if feed_favorite.save
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
