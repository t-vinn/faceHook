# rubocop: disable Metrics/AbcSize
module Users
  module Groups
    module GroupPosts
      class GroupPostFavoritesController < BaseController
        def create
          group = Group.find(params[:group_id])
          group_post_favorite = current_user.group_post_favorites.build(
            group_post_id: params[:group_post_id]
          )
          if group_post_favorite.save
            UserMailer.group_post_favorite_creation(group_post_favorite).deliver_later
            redirect_to users_group_path(group), notice: 'You liked a post!'
          else
            redirect_to users_group_path(group), notice: 'FAIL. Try again.'
          end
        end

        def destroy
          group = Group.find(params[:group_id])
          if GroupPostFavorite.find(params[:id]).destroy
            redirect_to users_group_path(group), notice: 'Your favorite deleted.'
          else
            flash.now[:notice] = 'An error occured and faceHook failed to delete your favorite.'
          end
        end
      end
    end
  end
end
