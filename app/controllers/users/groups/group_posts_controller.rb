# rubocop: disable Metrics/AbcSize
module Users
  module Groups
    class GroupPostsController < BaseController
      def create
        group = Group.find(params[:group_id])
        if group.users.exclude?(current_user)
          render_404
        else
          group_post = group.group_posts.new(group_post_params)
          if group_post.save
            UserMailer.group_post_creation(group_post).deliver_later
            message_service = SlackMessageService.new(group_post)
            message_service.send_to_times
            redirect_to users_group_path(group), notice: 'New group post!'
          else
            redirect_to users_group_path(group), notice: 'Failed. Try again.'
          end
        end
      end

      private

        def group_post_params
          params.require(:group_post).permit(:user_id, :group_id, :content,
                                             group_post_pictures_attributes: [:id, :picture,
                                                                              :_destroy])
        end
    end
  end
end
