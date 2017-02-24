module Users
  module Users
    class FeedFavoritesController < BaseController
      def create
        feed_favorite = FeedFavorite.new(user_id: current_user.id, feed_id: params[:feed_id])
        if feed_favorite.save
          redirect_to users_feeds_path, notice: 'You liked a feed!'
        else
          redirect_to users_feeds_path, notice: 'FAIL. Try again.'
        end
      end

      def destroy
        if FeedFavorite.find(params[:id]).destroy
          redirect_to users_feeds_path, notice: 'Your favorite deleted.'
        else
          flash.now[:notice] = 'An error occured and faceHook failed to delete your follow.'
        end
      end
    end
  end
end
