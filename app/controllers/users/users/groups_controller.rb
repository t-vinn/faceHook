module Users
  module Users
    class GroupsController < BaseController
      def index
        @group = Group.new
        @group.groups_users.build
        @groups = Group.all
      end

      def show
        @group = Group.find(params[:id])
        invited_users = User.find(@group.groups_users.pluck(:user_id))
        @invitable_users = @group.owner_user.mutual_followers - invited_users
      end

      def create
        group = Group.new(group_params)
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
        @group = Group.find(params[:id])
        if @group.update(params.require(:group).permit(:name))
          redirect_to users_groups_path, notice: 'the group name changed'
        else
          redirect_to users_groups_path, notice: "Couldn't change group name"
        end
      end

      private

        def group_params
          params.require(:group).permit(:name, :owner_user_id, groups_users_attributes: [:user_id])
        end
    end
  end
end
