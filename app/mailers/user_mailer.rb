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

  def reply_creation(reply)
    @sent_reply = reply
    mail to: [@sent_reply.user.email, @sent_reply.feed.user.email] | \
             User.find(@sent_reply.feed.replies.pluck(:user_id).uniq).pluck(:email),
         subject: 'A new reply posted'
  end
end
