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
        @following_feeds = Feed.where(
          privacy: [0, 1],
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
          params.require(:feed).permit(:user_id, :content, :privacy)
        end
    end
  end
end
