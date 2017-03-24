# rubocop: disable Metrics/AbcSize
module Users
  class GroupsController < BaseController
    def index
      @group = Group.new
      @group.groups_users.build
      groups = current_user.groups.sort_by(&:created_at).reverse
      @groups = Kaminari.paginate_array(groups).page(params[:page])
    end

    def show
      @group = Group.find(params[:id])
      if @group.users.exclude?(current_user)
        render_404
      else
        @group_post = GroupPost.new
        @group_post.group_post_pictures.build
        @group_post_favorites_index_by_group_post_id = \
          current_user.group_post_favorites.index_by(&:group_post_id)
        group_posts = @group.group_posts.sort_by(&:created_at).reverse
        @group_posts = Kaminari.paginate_array(group_posts).page(params[:page])
      end
    end

    def create
      group = Group.new(group_create_params)
      if group.save
        UserMailer.group_invitation(group.groups_users.first).deliver_later
        UserMailer.group_creation(group).deliver_later
        redirect_to users_groups_path, notice: 'a new group created!'
      else
        redirect_to users_groups_path, notice: 'The selected group name has already been taken.'
      end
    end

    def edit
      @group = Group.find(params[:id])
      if @group.owner_user_id != current_user.id
        render_404
      end
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
