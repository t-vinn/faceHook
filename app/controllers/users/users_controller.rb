class Users::UsersController < Users::BaseController
  def index
    @following_users = current_user.following_users
    #@unfollowing_users.delete(current_user) #これだとUser消えちゃう
    #@unfollowing_users.except(@following_users) #これだとUser消えちゃう
    #if @following_users.present?
    #  @unfollowing_users.reject(@following_users)
    #end
    #@unfollowing_users.reject(@following_users)
    #@following_users.each do |following_user|
      #@unfollowing_users.delete(following_user)
    #end
    @unfollowing_users = User.all - @following_users
  end
end
