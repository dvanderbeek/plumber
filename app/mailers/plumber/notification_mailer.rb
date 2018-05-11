module Plumber
  class NotificationMailer < ApplicationMailer
    def send_message(record:, message:)
      @record = record
      @message = message
      mail(to: record.email, subject: message.subject)
    end
  end
end
