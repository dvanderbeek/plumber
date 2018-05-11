module Plumber
  class NotificationMailer < ApplicationMailer
    def send_message(to:, message:)
      @message = message
      mail(to: to, subject: message.subject)
    end
  end
end
