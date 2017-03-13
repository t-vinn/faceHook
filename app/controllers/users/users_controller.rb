# rubocop: disable Metrics/AbcSize, Metrics/MethodLength
module Users
  class UsersController < BaseController
    def index
      @following_users = current_user.following_users
      @unfollowing_users = User.all - @following_users
      @unfollowing_users.delete(current_user)
      @follow_relationships_index_by_followee_user_id = \
        current_user.active_relationships.index_by(&:followee_user_id)
      @feed = Feed.new
      @feed.feed_pictures.build
      # show public feeds, current_user's own feeds, and feeds by users current_user follows
      feeds = Feed.share_with_all.or(Feed.where(user: current_user)).or(
        Feed.share_with_follower.where(user: current_user.following_users)
      )
      groups_owned_by_current_user = Group.where(owner_user_id: current_user.id)
      groups_current_user_is_a_member = Group.where(id: current_user.groups_users.pluck(:group_id))
      groups = groups_owned_by_current_user.or(groups_current_user_is_a_member)
      group_posts = GroupPost.where(group_id: groups.pluck(:id))
      feeds_or_group_posts = \
        (feeds | group_posts).sort_by(&:created_at).reverse
      @posts = Kaminari.paginate_array(feeds_or_group_posts).page(params[:page])
      following_feeds = Feed.where(
        privacy: [:share_with_all, :share_with_follower],
        user: current_user.following_users
      )
      following_feeds_or_group_posts = \
        (following_feeds | group_posts).sort_by(&:created_at).reverse
      @following_posts = Kaminari.paginate_array(following_feeds_or_group_posts).page(params[:page])
      @feed_favorites_index_by_feed_id = current_user.feed_favorites.index_by(&:feed_id)
      @reply_favorites_index_by_reply_id = current_user.reply_favorites.index_by(&:reply_id)
      @group_post_favorites_index_by_group_post_id = \
        current_user.group_post_favorites.index_by(&:group_post_id)
    end

    def show
      @user = User.find(params[:id])
      @feeds = @user.feeds.share_with_all.page(params[:page])
      @feed_favorites_index_by_feed_id = current_user.feed_favorites.index_by(&:feed_id)
      @reply_favorites_index_by_reply_id = current_user.reply_favorites.index_by(&:reply_id)
    end
  end
end
