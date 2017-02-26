module Users
  module Users
    class GroupsController < BaseController
      def index
        @group = Group.new
        @groups = Group.all
      end

      def show
        @group = Group.find(params[:id])
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
        if @group.update(group_params)
          redirect_to users_groups_path, notice: 'the group name changed'
        else
          redirect_to users_groups_path, notice: "Couldn't change group name"
        end
      end

      private

        def group_params
          params.require(:group).permit(:name)
        end
    end
  end
end
