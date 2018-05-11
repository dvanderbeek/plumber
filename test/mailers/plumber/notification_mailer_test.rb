require 'test_helper'

module Plumber
  class NotificationMailerTest < ActionMailer::TestCase
    test "send_message" do
      mail = NotificationMailer.send_message
      assert_equal "Send message", mail.subject
      assert_equal ["to@example.org"], mail.to
      assert_equal ["from@example.com"], mail.from
      assert_match "Hi", mail.body.encoded
    end

  end
end
