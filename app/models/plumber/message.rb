module Plumber
  class Message
    include ActiveModel::Model

    attr_accessor :id, :campaign_id, :subject, :template, :delay, :active

    def self.all
      Campaign.all.map(&:messages).flatten
    end

    def self.find(id)
      all.find { |c| c.id == id.to_i }
    end

    def self.where(conditions = {})
      all.select do |message|
        conditions.all? do |k, v|
          message.send(k) == v
        end
      end
    end

    def active?
      active
    end

    def campaign
      Campaign.find(campaign_id)
    end

    def body
      File.read(Rails.root.join("app", "views", "plumber", "messages", template))
    end
  end
end
