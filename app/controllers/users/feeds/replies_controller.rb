# rubocop: disable Metrics/AbcSize
module Users
  module Feeds
    class RepliesController < BaseController
      def new
        feed = Feed.find(params[:feed_id])
        if feed.repliable_by?(current_user)
          @feed = Feed.find(params[:feed_id])
          @reply = Reply.new
          @reply.reply_pictures.build
        else
          render_404
        end
      end

      def create
        feed = Feed.find(params[:feed_id])
        if feed.repliable_by?(current_user)
          reply = Reply.new(reply_params)
          if reply.save
            UserMailer.reply_creation(reply).deliver_later
            SlackMessageService.call(post_with_content: reply)
            redirect_to root_path, notice: 'You successfully replied to a comment!'
          else
            redirect_to new_users_feed_reply_path, notice: 'Your message is too short or long!'
          end
        else
          render_404
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
