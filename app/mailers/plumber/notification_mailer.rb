module Plumber
  class NotificationMailer < ApplicationMailer
    def send_message(record:, message_id:)
      @record = record
      @message = Message.find(message_id)
      mail(to: record.email, subject: message.subject)
    end
  end
end
