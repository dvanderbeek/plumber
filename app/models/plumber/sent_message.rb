module Plumber
  class SentMessage < ApplicationRecord
    belongs_to :record, polymorphic: true
    belongs_to :message
    has_one :campaign, through: :message

    after_create :deliver_message

    private

      def deliver_message
        puts "EMAILING #{message.subject} to #{record.email}"
      end
  end
end
