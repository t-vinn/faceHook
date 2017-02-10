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
          redirect_to '/', notice: 'a new feed created'
        else
          flash.now[:alert] = 'the message is too short'
          render :new
        end
      end

      private

        def feed_params
          params.require(:feed).permit(:user_id, :content, :privacy)
        end
    end
  end
end
