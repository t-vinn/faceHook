module Users
  module Groups
    class GroupPostsController < BaseController
      def create
        group = Group.find(params[:group_id])
        group_post = group.group_posts.new(group_post_params)
        if group_post.save
          redirect_to users_group_path(group), notice: 'New group post!'
        else
          redirect_to users_group_path(group), notice: 'Failed. Try again.'
        end
      end

      private

        def group_post_params
          params.require(:group_post).permit(:user_id, :group_id, :content,
                                             group_post_pictures_attributes: [:id, :picture, :_destroy])
        end
    end
  end
end
