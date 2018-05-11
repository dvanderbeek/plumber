module Plumber
  class Campaign
    include ActiveModel::Model

    attr_accessor :id, :title, :record_class, :delay_column, :filter, :messages

    def self.all
      CampaignDefinition.all
    end

    def self.find(id)
      all.find { |c| c.id == id.to_i }
    end

    def self.send!(date = Date.current)
      all.each do |campaign|
        campaign.send_messages(date)
      end
    end

    def send_messages(date = Date.current)
      messages.select { |m| m.active }.each do |message|
        records.where("date(#{record_table}.#{delay_column}) = ?", (date - message.delay.days).to_date).each do |record|
          SentMessage.find_or_create_by(record: record, message_id: message.id)
        end
      end
    end

    def records
      model.ransack(filter).result
    end

    private

      def model
        @model ||= record_class.safe_constantize
      end

      def record_table
        model.table_name
      end
  end
end
