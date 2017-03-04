require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "feed_creation" do
    mail = UserMailer.feed_creation
    assert_equal "Feed creation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
