class Users::FollowRelationshipsController < Users::BaseController

  def index
    @users = User.all
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
    @follow_relationship.user = current_user



    if @follow_relationship.save!
      redirect_to users_user_follow_relationships_path(current_user.id)
      flash.now[:alert] = 'Followed new person!'
    else
      flash.now[:alert] = 'follow failed!'
    end
  end
end
