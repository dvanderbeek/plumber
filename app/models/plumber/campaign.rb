module Plumber
  class Campaign < ApplicationRecord
    has_many :entrances
    has_many :messages

    validate :record_class_is_active_record
    validate :delay_column_is_date_or_time

    # TODO: Save in db ##########################
    def filter
      case title
      when "Adverse Action"
        { status_eq: "declined" }
      when "Lending Tree Welcome"
        { status_eq: "open", lead_source_eq: "lending_tree", customer_sign_in_count_lteq: 3 }
      end
    end
    # END ########################################

    def records
      model.ransack(filter).result
    end

    def self.send_messages(date = Date.current)
      all.find_each do |campaign|
        campaign.send_messages(date)
      end
    end

    def send_messages(date = Date.current)
      messages.where(active: true).each do |message|
        records.where("date(#{record_table}.#{delay_column}) = ?", (date - message.delay.days).to_date).each do |record|
          SentMessage.find_or_create_by(record: record, message: message)
        end
      end
    end

    private

      def record_table
        model.table_name
      end

      def record_class_is_active_record
        unless model && model.ancestors.include?(ActiveRecord::Base)
          errors.add(:record_class, "must be an ActiveRecord model")
        end
      end

      def delay_column_is_date_or_time
        column = model && model.columns.find { |c| c.name == delay_column }
        if column.nil? || column.type != :datetime
          errors.add(:delay_column, "must be a timestamp")
        end
      end

      def model
        @model ||= record_class.safe_constantize
      end
  end
end
