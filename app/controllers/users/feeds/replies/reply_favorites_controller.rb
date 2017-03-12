# rubocop: disable Metrics/AbcSize
module Users
  module Feeds
    module Replies
      class ReplyFavoritesController < BaseController
        def create
          feed = Feed.find(params[:feed_id])
          unless feed.privacy == 'share_with_only_me' ||
                 feed.privacy == 'share_with_follower' &&
                 current_user.following_users.exclude?(feed.user)
            reply_favorite = current_user.reply_favorites.build(reply_id: params[:reply_id])
            if reply_favorite.save
              redirect_to root_path, notice: 'You liked a reply!'
            else
              redirect_to root_path, notice: 'FAIL. Try again.'
            end
          end
        end

        def destroy
          if ReplyFavorite.find(params[:id]).destroy
            redirect_to root_path, notice: 'Your favorite deleted.'
          else
            flash.now[:notice] = 'An error occured and faceHook failed to delete your favorite.'
          end
        end
      end
    end
  end
end
