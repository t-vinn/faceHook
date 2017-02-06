class Users::FollowRelationshipsController < Users::BaseController

  def index
    @active_relationships = FollowRelationship.where(:follower_user_id => current_user.id)

    @unfollowing_users = User.all
    @following_users = current_user.following_users
    @unfollowing_users.delete(current_user) #これだとUser消えちゃう
    @unfollowing_users.except(@following_users) #これだとUser消えちゃう
    #@following_users.each do |following_user|
      #@unfollowing_users.delete(following_user)
    #end


  end

  def new
    @followee = User.find(params[:id])
    @follow_relationship = FollowRelationship.new
  end

  def create
    #@id = FollowRelationship.count + 1
    #@followee_id = params[:followee_id]
    #@created = Time.now
    #@follow_relationship = FollowRelationship.create(id: @id, follower_user_id: current_user.id, followee_user_id: @followee_id, created_at: @created, updated_at: @created)
    @follow_relationship = FollowRelationship.new(params.require(:follow_relationship).permit(:follower_user_id, :followee_user_id))

    if @follow_relationship.save!
      redirect_to users_user_follow_relationships_path(current_user.id)
      flash.now[:alert] = 'Followed new person!'
    else
      flash.now[:alert] = 'follow failed!'
    end
  end
end
