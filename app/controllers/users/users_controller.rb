module Users
  class UsersController < BaseController
    def index
      @following_users = current_user.following_users
      @unfollowing_users = User.all - @following_users
      @unfollowing_users.delete(current_user)

      @follow_relationships_index_by_followee_user_id = \
        current_user.active_relationships.index_by(&:followee_user_id)
    end
  end
end
