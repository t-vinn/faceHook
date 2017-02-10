module Users
  module Users
    class FeedsController < BaseController
      def index
        @feed = Feed.new
        @feeds = Feed.where(
          privacy: 1,
          user: current_user.following_users
        ).or(Feed.where(
               privacy: 0
        )).or(Feed.where(
                user: current_user
        ))
      end

      def create
        if Feed.create(feed_params)
          redirect_to users_feeds_path, notice: 'a new feed created'
        else
          redirect_to users_feeds_path, notice: 'your message is too long!'
        end
      end

      private

        def feed_params
          params.require(:feed).permit(:user_id, :content, :privacy)
        end
    end
  end
end
