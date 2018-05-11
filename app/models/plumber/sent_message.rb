module Plumber
  class SentMessage < ApplicationRecord
    belongs_to :record, polymorphic: true
    has_one :campaign, through: :message

    after_create :deliver_message

    def message
      Message.find(message_id)
    end

    private

      def deliver_message
        NotificationMailer.send_message(
          record: record,
          message_id: message_id
        ).deliver_later
      end
  end
end
