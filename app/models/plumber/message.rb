module Plumber
  class Message
    include ActiveModel::Model

    attr_accessor :id, :campaign, :subject, :template, :delay, :active

    alias_method :active?, :active

    def self.all
      Campaign.all.map(&:messages).flatten
    end

    def self.find(id)
      all.find { |e| e.id == id.to_i }
    end

    def self.where(conditions = {})
      all.select do |message|
        conditions.all? do |k, v|
          message.send(k) == v
        end
      end
    end

    def body
      @body ||= File.read(Rails.root.join("app", "views", "plumber", "messages", template))
    end

    def parsed_template
      @parsed_template ||= Liquid::Template.parse(body)
    end

    def html(record)
      parsed_template.render(record.to_h.deep_stringify_keys)
    end
  end
end
