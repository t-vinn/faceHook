class FollowRelationshipsController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @follow_relationship = FollowRelationship.new
  end

  def create
    @follow_relationship = FollowRelationship.new(params.require(:follow_relationship).permit(:follower_user_id, :followee_user_id))

    if @follow_relationship.save
      redirect_to user_follow_relationships_path(current_user.id)
      flash.now[:alert] = 'Followed new person!'
    else
      redirect_to user_follow_relationships_path(current_user.id)
      flash.now[:alert] = 'follow failed!'
    end
  end
end
