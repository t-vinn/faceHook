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
    mail to: feed.user.email, subject: 'A new feed posted' if feed.user.notification_allowed == true
  end

  def feed_favorite_creation(feed_favorite)
    @feed_favorite = feed_favorite
    receiving_users = feed_favorite.related_users & \
                      User.where(notification_allowed: true)
    mail to: receiving_users.pluck(:email), subject: 'A feed liked' if receiving_users.present?
  end

  def reply_creation(reply)
    @sent_reply = reply
    receiving_users = reply.related_users & User.where(notification_allowed: true)
    mail to: receiving_users.pluck(:email), subject: 'A new reply posted' \
      if receiving_users.present?
  end

  def reply_favorite_creation(reply_favorite)
    @reply_favorite = reply_favorite
    receiving_users = reply_favorite.related_users &
                      User.where(notification_allowed: true)
    mail to: receiving_users.pluck(:email), subject: 'A reply liked' if receiving_users.present?
  end

  def group_post_creation(group_post)
    @sent_group_post = group_post
    receiving_users = User.where(notification_allowed: true) & group_post.group.members
    mail to: receiving_users.pluck(:email), subject: 'A new group post created' \
      if receiving_users.present?
  end

  def group_post_favorite_creation(group_post_favorite)
    @group_post_favorite = group_post_favorite
    gp = group_post_favorite.group_post
    possible_receivers = group_post_favorite.related_users.push(gp.group.owner_user)
    receiving_users =  possible_receivers & User.where(notification_allowed: true)
    mail to: receiving_users.pluck(:email), subject: 'A group post liked' \
      if receiving_users.present?
  end

  def group_creation(group)
    @group = group
    mail to: group.owner_user.email, subject: 'Created a new group' \
      if group.owner_user.notification_allowed == true
  end

  def group_invitation(groups_user)
    @groups_user = groups_user
    mail to: groups_user.user.email, subject: "You're invited to a new group"
  end

  def group_new_member(groups_user)
    @groups_user = groups_user
    receiving_users = (groups_user.group.members - [groups_user.user]) & \
                      User.where(notification_allowed: true)
    mail to: receiving_users.pluck(:email), subject: 'A new member invited to the group' \
      if receiving_users.present?
  end
end
