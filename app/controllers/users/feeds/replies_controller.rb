module Users
  module Feeds
    class RepliesController < BaseController
      def new
        @feed = Feed.find(params[:feed_id])
        @reply = Reply.new
      end

      def create
        @reply = Reply.new(reply_params)
        if @reply.save
          UserMailer.reply_creation(@reply).deliver
          redirect_to users_feeds_path, notice: 'You successfully replied to a comment!'
        else
          redirect_to new_users_feed_reply_path, notice: 'Your message is too short or long!'
        end
      end

      private

        def reply_params
          params.require(:reply).permit(:user_id, :content, :feed_id)
        end
    end
  end
end
