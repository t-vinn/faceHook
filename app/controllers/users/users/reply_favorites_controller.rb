module Users
  module Users
    class ReplyFavoritesController < BaseController
      def create
        reply_favorite = ReplyFavorite.new(user_id: current_user.id, reply_id: params[:reply_id])
        if reply_favorite.save
          redirect_to users_feeds_path, notice: 'You liked a reply!'
        else
          redirect_to users_feeds_path, notice: 'FAIL. Try again.'
        end
      end

      def destroy
        if ReplyFavorite.find(params[:id]).destroy
          redirect_to users_feeds_path, notice: 'Your favorite deleted.'
        else
          flash.now[:notice] = 'An error occured and faceHook failed to delete your favorite.'
        end
      end
    end
  end
end
