module Plumber
  class Campaign
    include ActiveModel::Model

    attr_accessor :id, :title, :record_class, :delay_column, :filter, :messages, :start_sending, :stop_sending

    def self.all
      CampaignDefinition.all
    end

    def self.find(slug)
      all.find { |e| e.slug == slug }
    end

    def self.send!(as_of = Time.current)
      all.each do |campaign|
        if as_of.hour.between?(campaign.start_sending, campaign.stop_sending)
          campaign.send_messages(as_of)
        end
      end
    end

    def send_messages(as_of = Time.current)
      messages.select { |m| m.active }.each do |message|
        records_to_send(as_of, message).each do |record|
          SentMessage.find_or_create_by(record: record, message_id: message.id)
        end
      end
    end

    def records_to_send(as_of, message)
      target_date = as_of.to_date - message.delay.days
      records.where("date(#{record_table}.#{delay_column}) BETWEEN ? AND ?", target_date.yesterday, target_date)
    end

    def upcoming_records
      records.where("date(#{record_table}.#{delay_column}) BETWEEN ? AND ?", Date.current - delays.max.days, Date.current)
    end

    def records
      model.ransack(filter).result
    end

    def delays
      messages.map(&:delay)
    end

    def messages=(array)
      array.map { |e| e.campaign = self }
      @messages = array
    end

    def slug
      title.parameterize
    end

    def start_sending
      @start_sending ||= 0
    end

    def stop_sending
      @stop_sending ||= 23
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
