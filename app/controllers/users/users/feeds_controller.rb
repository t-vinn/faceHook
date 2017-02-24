module Users
  module Users
    class FeedsController < BaseController
      def index
        @feed = Feed.new
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
      end

      def create
        if Feed.create!(feed_params)
          redirect_to users_feeds_path, notice: 'a new feed created'
        else
          redirect_to users_feeds_path, notice: 'your message is too short or long!'
        end
      end

      private

        def feed_params
          params.require(:feed).permit(:user_id, :content, :privacy)
        end
    end
  end
end
