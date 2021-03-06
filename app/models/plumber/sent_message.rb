module Plumber
  class SentMessage < ApplicationRecord
    belongs_to :record, polymorphic: true

    before_create :deliver_message, on: :create

    private

      def deliver_message
        return unless record.email.present?
        self.email = record.email
        NotificationMailer.send_message(
          record: record,
          message_id: message_id
        ).deliver_later
      end
  end
end
