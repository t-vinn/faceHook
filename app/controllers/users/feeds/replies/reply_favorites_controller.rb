# rubocop: disable Metrics/AbcSize
module Users
  module Feeds
    module Replies
      class ReplyFavoritesController < BaseController
        def create
          feed = Feed.find(params[:feed_id])
          reply = Reply.find(params[:reply_id])
          if feed.repliable_by?(current_user) && reply.user != current_user
            reply_favorite = current_user.reply_favorites.build(reply_id: params[:reply_id])
            if reply_favorite.save
              UserMailer.reply_favorite_creation(reply_favorite).deliver_later
              redirect_to params[:path], notice: 'You liked a reply!'
            else
              redirect_to params[:path], notice: 'FAIL. Try again.'
            end
          else
            render_404
          end
        end

        def destroy
          if ReplyFavorite.find(params[:id]).destroy
            redirect_to params[:path], notice: 'Your favorite deleted.'
          else
            flash.now[:notice] = 'An error occured and faceHook failed to delete your favorite.'
          end
        end
      end
    end
  end
end
