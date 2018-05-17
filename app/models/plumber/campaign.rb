module Plumber
  class Campaign
    include ActiveModel::Model

    attr_accessor :id, :title, :record_class, :delay_column, :filter, :messages, :start_sending, :stop_sending

    def self.all
      CampaignDefinition.list_campaigns
    end

    def self.find(id)
      CampaignDefinition.get_campaign(id)
    end

    def self.send!(as_of = Time.current)
      all.each do |campaign|
        campaign.send_messages(as_of)
      end
    end

    def send_messages(as_of = Time.current)
      start_time = as_of.change(hour: start_sending, min: 0, sec: 0)
      stop_time  = as_of.change(hour: stop_sending, min: 0, sec: 0)
      return unless as_of >= start_time && as_of <= stop_time
      active_messages.each do |message|
        records_to_send(as_of, message).each do |record|
          SentMessage.find_or_create_by(record: record, message_id: message.id)
        end
      end
    end

    def records_to_send(as_of, message)
      target_date = as_of.to_date - message.delay.days
      # Look back 1 hour to make sure we catch records close to cutoff
      start = target_date.yesterday.noon.change(hour: stop_sending - 1, min: 0, sec: 0)
      stop  = target_date.noon.change(hour: as_of.hour, min: as_of.min, sec: as_of.sec)
      records.where("#{record_table}.#{delay_column} > ?", start)
             .where("#{record_table}.#{delay_column} <= ?", stop)
    end

    def upcoming_records
      return records unless messages.any?
      target_date = Date.current.to_date - delays.max.days
      start = target_date.yesterday.noon.change(hour: stop_sending, min: 0, sec: 0)
      records.where("#{record_table}.#{delay_column} > ?", start)
    end

    def records
      model.ransack(filter).result
    end

    def delays
      messages.map(&:delay)
    end

    def messages=(array)
      @messages = array.map { |e| m = Message.new(e); m.campaign = self; m }
    end

    def active_messages
      messages.select { |m| m.active }
    end

    def slug
      title.parameterize
    end

    def start_sending
      @start_sending ||= 0
    end

    def stop_sending
      @stop_sending ||= 24
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
