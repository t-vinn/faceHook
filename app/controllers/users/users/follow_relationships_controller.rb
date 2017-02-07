module Users
  module Users
    class FollowRelationshipsController < BaseController
      def create
        if FollowRelationship.create(follow_relatinoship_params)
          redirect_to root_path, notice: 'Followed new person!'
        else
          flash.now[:alert] = 'follow failed!'
        end
      end

      def destroy
        if FollowRelationship.find(params[:id]).destroy
          redirect_to root_path, notice: 'Your follow deleted.'
        else
          flash.now[:notice] = 'An error occured and faceHook failed to delete your follow.'
        end
      end

      private

        def follow_relatinoship_params
          params.require(:follow_relationship).permit(:follower_user_id, :followee_user_id)
        end
    end
  end
end
