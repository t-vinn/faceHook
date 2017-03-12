# rubocop: disable Metrics/AbcSize
module Users
  module Feeds
    class RepliesController < BaseController
      def new
        feed = Feed.find(params[:feed_id])
        if feed.privacy == 'share_with_only_me' ||
           feed.privacy == 'share_with_follower' &&
           current_user.following_users.exclude?(feed.user)
          render file: 'public/404.html', status: :not_found, layout: false
        else
          @feed = Feed.find(params[:feed_id])
          @reply = Reply.new
          @reply.reply_pictures.build
        end
      end

      def create
        feed = Feed.find(params[:feed_id])
        unless feed.privacy == 'share_with_only_me' ||
               feed.privacy == 'share_with_follower' &&
               current_user.following_users.exclude?(feed.user)
          reply = Reply.new(reply_params)
          if reply.save
            redirect_to root_path, notice: 'You successfully replied to a comment!'
          else
            redirect_to new_users_feed_reply_path, notice: 'Your message is too short or long!'
          end
        end
      end

      private

        def reply_params
          params.require(:reply).permit(:user_id, :content, :feed_id,
                                        reply_pictures_attributes: [:picture])
        end
    end
  end
end
