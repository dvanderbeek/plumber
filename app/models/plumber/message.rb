module Plumber
  class Message
    include ActiveModel::Model

    attr_accessor :id, :campaign, :from, :subject, :template, :delay, :active

    alias_method :active?, :active

    def self.find(id)
      Repo.get_message(id)
    end

    def initialize(attrs = {})
      attrs = attrs.with_indifferent_access
      self.id = attrs[:id]
      self.from = attrs[:from] if attrs[:from]
      self.subject = attrs[:subject]
      self.template = attrs[:template]
      self.delay = attrs[:delay]
      self.active = attrs[:active]
      self.campaign = Campaign.new(attrs[:campaign]) if attrs[:campaign]
    end

    def parsed_template
      @parsed_template ||= Liquid::Template.parse(template)
    end

    def html(record)
      parsed_template.render(record.to_h.deep_stringify_keys)
    end

    def from
      super || Plumber.email_from
    end
  end
end
