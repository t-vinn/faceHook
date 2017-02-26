module Users
  module Users
    class GroupsController < BaseController
      def index
        @group = Group.new
        @groups = Group.all 
      end

      def create
        group = Group.new(group_params)
        if group.save
          redirect_to users_groups_path, notice: 'a new group created!'
        elsif
          redirect_to users_groups_path, notice: 'The selected group name has already been taken.'
        end
      end

      private

        def group_params
          params.require(:group).permit(:name)
        end
    end
  end
end


