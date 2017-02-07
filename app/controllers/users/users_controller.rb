module Users
  class UsersController < BaseController
    def index
      @following_users = current_user.following_users
      @unfollowing_users = User.all - @following_users
      @unfollowing_users.delete(current_user)
    end
  end
end
