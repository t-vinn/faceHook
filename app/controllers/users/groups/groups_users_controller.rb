# rubocop: disable Metrics/AbcSize
module Users
  module Groups
    class GroupsUsersController < BaseController
      def create
        group = Group.find(params[:group_id])
        groups_user = group.groups_users.build(user_id: params[:user_id])
        if groups_user.save
          UserMailer.group_invitation(groups_user).deliver_later
          UserMailer.group_new_member(groups_user).deliver_later
          redirect_to users_group_path(group), notice: 'New member added to the group'
        else
          redirect_to users_group_path(group), notice: 'Failed. Try again.'
        end
      end

      def destroy
        group = Group.find(params[:group_id])
        groups_user = GroupsUser.find(params[:id])
        if groups_user.destroy
          redirect_to users_group_path(group), notice: 'A member deleted from the group'
        else
          redirect_to users_group_path(group), notice: 'Failed. Try again.'
        end
      end
    end
  end
end
