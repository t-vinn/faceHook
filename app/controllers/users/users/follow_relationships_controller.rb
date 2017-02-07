class Users::Users::FollowRelationshipsController < Users::BaseController

  def index
  end

  def new
    @followee = User.find(params[:id])
    @follow_relationship = FollowRelationship.new
  end

  def create
    @follow_relationship = FollowRelationship.new(params.require(:follow_relationship).permit(:follower_user_id, :followee_user_id))

    if @follow_relationship.save!
      redirect_to root_path, notice: 'Followed new person!'
    else
      flash.now[:alert] = 'follow failed!'
    end
  end

  def destroy
    @follow_relationship = FollowRelationship.find(params[:id])

    if @follow_relationship.destroy
      redirect_to root_path, notice: 'Your follow deleted.'
    else
      flash.now[:notice] = 'An error occured and faceHook failed to delete your follow.'
    end
  end
end
