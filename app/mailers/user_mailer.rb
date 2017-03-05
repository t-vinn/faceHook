class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.feed_creation.subject
  #
  def feed_creation(feed)
    @sent_feed = feed
    mail to: @sent_feed.user.email, subject: 'A new feed posted'
  end

  def feed_favorite_creation(feed_favorite)
    @feed_favorite = feed_favorite
    mail to: [feed_favorite.user.email, feed_favorite.feed.user.email],
         subject: 'A feed liked'
  end

  def reply_creation(reply)
    @sent_reply = reply
    mail to: [@sent_reply.user.email, @sent_reply.feed.user.email] | \
             User.find(@sent_reply.feed.replies.pluck(:user_id).uniq).pluck(:email),
         subject: 'A new reply posted'
  end

  def group_post_creation(group_post)
    @sent_group_post = group_post
    mail to: User.find(@sent_group_post.group.groups_users.pluck(:user_id).uniq) \
      .pluck(:email).push(@sent_group_post.group.owner_user.email),
         subject: 'A new group post created'
  end

  def group_post_favorite_creation(group_post_favorite)
    @group_post_favorite = group_post_favorite
    mail to: User.find(@group_post_favorite.group_post.group.groups_users.pluck(:user_id).uniq) \
      .pluck(:email).push(@group_post_favorite.group_post.group.owner_user.email),
         subject: 'A group post liked'
  end
end
