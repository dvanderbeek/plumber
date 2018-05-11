module Plumber
  class SentMessage < ApplicationRecord
    belongs_to :record, polymorphic: true
    belongs_to :message
    has_one :campaign, through: :message

    after_create :deliver_message

    private

      def deliver_message
        NotificationMailer.send_message(to: record.email, message: message).deliver_later
      end
  end
end
