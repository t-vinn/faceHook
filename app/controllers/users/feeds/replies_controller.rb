module Users
  module Feeds
    class RepliesController < BaseController
      def new
        @feed = Feed.find(params[:feed_id])
        @reply = Reply.new
        @reply.reply_pictures.build
      end

      def create
        reply = Reply.new(reply_params)
        if reply.save
          UserMailer.reply_creation(reply).deliver_later
          redirect_to root_path, notice: 'You successfully replied to a comment!'
        else
          redirect_to new_users_feed_reply_path, notice: 'Your message is too short or long!'
        end
      end

      private

        def reply_params
          params.require(:reply).permit(:user_id, :content, :feed_id,
                                        reply_pictures_attributes: [:id, :picture, :_destroy])
        end
    end
  end
end
