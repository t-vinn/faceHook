# rubocop: disable Metrics/AbcSize
class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.feed_creation.subject
  #
  # possible_receivers : users who notification emails will be sent to because of the action
  # receiving_users: possible_receivers who also set the notification on
  def feed_creation(feed)
    @sent_feed = feed
    mail to: @sent_feed.user.email, subject: 'A new feed posted' \
      if @sent_feed.user.notification_allowed == 1
  end

  def feed_favorite_creation(feed_favorite)
    @feed_favorite = feed_favorite
    receiving_users = [feed_favorite.user, feed_favorite.feed.user] & \
                      User.where(notification_allowed: true)
    mail to: receiving_users.pluck(:email), subject: 'A feed liked' if receiving_users.present?
  end

  def reply_creation(reply)
    @sent_reply = reply
    receiving_users = (User.where(notification_allowed: true) &
      [@sent_reply.user, @sent_reply.feed.user] | \
      User.find(@sent_reply.feed.replies.pluck(:user_id).uniq))
    mail to: receiving_users.pluck(:email), subject: 'A new reply posted' \
      if receiving_users.present?
  end

  def reply_favorite_creation(reply_favorite)
    @reply_favorite = reply_favorite
    receiving_users = ([reply_favorite.user, reply_favorite.reply.user] &
      User.where(notification_allowed: true))
    mail to: receiving_users.pluck(:email), subject: 'A reply liked' if receiving_users.present?
  end

  def group_post_creation(group_post)
    @sent_group_post = group_post
    receiving_users = (User.find(@sent_group_post.group.groups_users.pluck(:user_id).uniq) \
      .push(@sent_group_post.group.owner_user) & User.where(notification_allowed: true))
    mail to: receiving_users.pluck(:email), subject: 'A new group post created' \
      if receiving_users.present?
  end

  def group_post_favorite_creation(group_post_favorite)
    @group_post_favorite = group_post_favorite
    possible_receivers = User.find(@group_post_favorite.group_post.group.groups_users \
      .pluck(:user_id).uniq.push(@group_post_favorite.group_post.group.owner_user))
    receiving_users =  possible_receivers & User.where(notification_allowed: true)
    mail to: receiving_users.pluck(:email), subject: 'A group post liked' \
      if receiving_users.present?
  end
end
