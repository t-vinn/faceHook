module ApplicationHelper
  def favorite_links(post)
    if post.user_id == current_user.id
      # Can't like your own post.
      '*'
    elsif post.group_post_favorites.exists?(user_id: current_user.id)
      link_to('Remove Favorite',
              users_group_group_post_group_post_favorite_path(
                @group, post,
                @group_post_favorites_index_by_group_post_id[post.id]
              ), method: :delete)
    else
      link_to('Favorite', users_group_group_post_group_post_favorites_path(@group, post),
              method: :post)
    end
  end
end
