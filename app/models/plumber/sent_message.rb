module Plumber
  class SentMessage < ApplicationRecord
    belongs_to :entrance
    belongs_to :campaign_message
    has_one :message, through: :campaign_message
    has_one :campaign, through: :campaign_message

    after_create :deliver_message

    delegate :record, to: :entrance

    private

      def deliver_message
        puts "EMAILING #{campaign_message.message.subject} to #{record.email}"
      end
  end
end
