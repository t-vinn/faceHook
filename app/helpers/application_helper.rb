# rubocop: disable Metrics/AbcSize
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

  def cos_similarity(id1, id2)
    user1_following_ids = FollowRelationship.where(follower_user_id: id1).pluck( \
      :followee_user_id) - [id2]
    user2_following_ids = FollowRelationship.where(follower_user_id: id2).pluck( \
      :followee_user_id) - [id1]
    inner_product = (user1_following_ids & user2_following_ids).length
    a = user1_following_ids.length
    b = user2_following_ids.length
    if a * b == 0
      0
    else
      inner_product / (a * b) .to_f
    end
  end

  def follow_links(user, index)
    if current_user.following?(user)
      link_to 'Unfollow',
              users_follow_relationship_path(index[user.id]),
              method: :delete,
              data: { confirm: 'Unfollow this person?' },
              class: 'btn btn-primary'
    else
      link_to 'Follow', users_follow_relationships_path(followee_user_id: user.id),
              method: :post, class: 'btn btn-primary'
    end
  end
end
