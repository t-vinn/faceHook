module Users
  module Users
    class FeedFavoritesController < BaseController
      def create
        if FeedFavorite.create!(user_id: current_user.id, feed_id: params[:feed_id])
          redirect_to users_feeds_path, notice: 'You liked a feed!'
        else
          redirect_to root_path, notice: 'FAIL'
        end
      end

      def destroy; end
    end
  end
end
