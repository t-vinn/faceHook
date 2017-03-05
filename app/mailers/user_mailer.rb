class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.feed_creation.subject
  #
  def feed_creation(feed)
    @sent_feed = feed
    mail to: @sent_feed.user.email, subject: 'A new feed posted' \
      if @sent_feed.user.notification_allowed == 1
  end

  def feed_favorite_creation(feed_favorite)
    @feed_favorite = feed_favorite
    mail to: ([feed_favorite.user, feed_favorite.feed.user] & \
              User.where(notification_allowed: true)).pluck(:email),
         subject: 'A feed liked'
  end

  def reply_creation(reply)
    @sent_reply = reply
    mail to: (([@sent_reply.user, @sent_reply.feed.user] | \
              User.find(@sent_reply.feed.replies.pluck(:user_id).uniq)) &
              User.where(notification_allowed: true)).pluck(:email),
         subject: 'A new reply posted'
  end

  def reply_favorite_creation(reply_favorite)
    @reply_favorite = reply_favorite
    mail to: ([reply_favorite.user, reply_favorite.reply.user] &
              User.where(notification_allowed: true)).pluck(:email),
         subject: 'A reply liked'
  end

  def group_post_creation(group_post)
    @sent_group_post = group_post
    mail to: (User.find(@sent_group_post.group.groups_users.pluck(:user_id).uniq) \
              .push(@sent_group_post.group.owner_user) &
              User.where(notification_allowed: true)).pluck(:email),
         subject: 'A new group post created'
  end

  def group_post_favorite_creation(group_post_favorite)
    @group_post_favorite = group_post_favorite
    mail to: (User.find(@group_post_favorite.group_post.group.groups_users.pluck(:user_id).uniq) \
              .push(@group_post_favorite.group_post.group.owner_user) &
              User.where(notification_allowed: true)).pluck(:email),
         subject: 'A group post liked'
  end
end
