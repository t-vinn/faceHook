# rubocop: disable Metrics/AbcSize
module Users
  class FeedsController < BaseController
    def index
      @feed = Feed.new
      @feed.feed_pictures.build
      # show public feeds, current_user's own feeds, and feeds by users current_user follows
      @feeds = Feed.share_with_all.or(Feed.where(
        user: current_user
      )).or(Feed.share_with_follower.where(
        user: current_user.following_users
      ))
      @following_feeds = Feed.where(
        privacy: [:share_with_all, :share_with_follower],
        user: current_user.following_users
      )
      @feed_favorites_index_by_feed_id = \
        current_user.feed_favorites.index_by(&:feed_id)
      @reply_favorites_index_by_reply_id = \
        current_user.reply_favorites.index_by(&:reply_id)
    end

    def create
      if Feed.create!(feed_params)
        redirect_to users_feeds_path, notice: 'a new feed created'
      else
        redirect_to users_feeds_path, notice: 'your message is too short or long!'
      end
    end

    def edit
      @feed = Feed.find(params[:id])
    end

    def update
      @feed = Feed.find(params[:id])
      if @feed.update(feed_params)
        redirect_to users_feeds_path, notice: 'the privacy of your feed revised'
      else
        flash.now[:alert] = "We couldn't update the privacy."
        render :edit
      end
    end

    private

      def feed_params
        params.require(:feed).permit(:user_id, :content, :privacy,
                                       feed_pictures_attributes: [:picture])
      end
  end
end
