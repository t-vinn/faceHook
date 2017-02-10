module Users
  module Users
    class FeedsController < BaseController
      def index
        @feed = Feed.new
        @feeds = Feed.all
      end

      def create
        @feed = Feed.new(feed_params)
        if @feed.save
          redirect_to '/users/feeds', notice: 'a new feed created'
        else
          redirect_to '/users/feeds', notice: 'your message is too long!'
        end
      end

      private

        def feed_params
          params.require(:feed).permit(:user_id, :content, :privacy)
        end
    end
  end
end
