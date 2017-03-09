# rubocop: disable Metrics/AbcSize
module Users
  class GroupsController < BaseController
    def index
      @group = Group.new
      @group.groups_users.build
      @groups = (Group.find(current_user.groups_users.pluck(:group_id)) | \
                 Group.where(owner_user_id: current_user.id)).sort_by(&:created_at).reverse
    end

    def show
      @group = Group.find(params[:id])
      @not_a_member_condition = (current_user.groups_users & @group.groups_users).blank? && \
                                @group.owner_user != current_user
      @group_post = GroupPost.new
      @group_post.group_post_pictures.build
      @group_posts = @group.group_posts.sort_by(&:created_at).reverse
      @group_post_favorites_index_by_group_post_id = \
        current_user.group_post_favorites.index_by(&:group_post_id)
    end

    def create
      group = Group.new(group_create_params)
      if group.save
        redirect_to users_groups_path, notice: 'a new group created!'
      else
        redirect_to users_groups_path, notice: 'The selected group name has already been taken.'
      end
    end

    def edit
      @group = Group.find(params[:id])
    end

    def update
      group = Group.find(params[:id])
      if group.update(group_update_params)
        redirect_to users_groups_path, notice: 'The group name changed'
      else
        redirect_to edit_users_group_path(group), notice: 'New name already used'
      end
    end

    private

      def group_create_params
        params.require(:group).permit(:name, :owner_user_id, groups_users_attributes: [:user_id])
      end

      def group_update_params
        params.require(:group).permit(:name)
      end
  end
end
