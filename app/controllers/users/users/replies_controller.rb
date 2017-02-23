module Users
  module Users
    class RepliesController < BaseController
      before_action :set_feed, only: [:new]

      def new
        @reply = Reply.new
      end

      def create
        if Reply.create!(reply_params)
          redirect_to users_feeds_path, notice: 'You successfully replied to a comment!'
        else
          redirect_to users_feeds_path, notice: 'Your message is too short or long!'
        end
      end

      private

        def set_feed
          @feed = Feed.find(params[:feed_id])
        end

        def reply_params
          params.require(:reply).permit(:user_id, :content, :feed_id)
        end
    end
  end
end
