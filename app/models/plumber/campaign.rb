module Plumber
  class Campaign < ApplicationRecord
    has_many :entrances
    has_many :campaign_messages
    has_many :messages, through: :campaign_messages

    # TODO: Use Ransack ##########################
    def filter
      { status: "declined" }
    end

    def records
      record_class.safe_constantize.where(filter)
    end
    # END TODO ###################################

    def send_messages(date = Date.current)
      record_entrances
      record_exits
      campaign_messages.each do |cm|
        entrances.reload.where(exited: false).where("created_at::date = ?", date - cm.delay.days).each do |entrance|
          SentMessage.find_or_create_by(entrance: entrance, campaign_message: cm)
        end
      end
    end

    private

      def record_table
        record_class.safe_constantize.table_name
      end

      def record_entrances
        # Records who match the campaign's filters and do not have an active Entrance in the campaign
        records.where.not(id: entrances.where(exited: false).pluck(:record_id)).each do |record|
          entrances.create(record: record)
        end
      end

      def record_exits
        # Entrances where the record no longer matches the campaign's filters
        exits_to_record.update_all(exited: true) if exits_to_record.any?
      end

      def exits_to_record
        entrances.joins("JOIN #{record_table} ON #{record_table}.id = plumber_entrances.record_id")
                 .where(exited: false)
                 .where.not(record_table => filter)
      end
  end
end
