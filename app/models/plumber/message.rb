module Plumber
  class Message
    include ActiveModel::Model

    attr_accessor :id, :campaign_id, :campaign, :subject, :template, :delay, :active

    alias_method :active?, :active

    def self.find(id)
      CampaignDefinition.get_message(id)
    end

    def parsed_template
      @parsed_template ||= Liquid::Template.parse(template)
    end

    def html(record)
      parsed_template.render(record.to_h.deep_stringify_keys)
    end
  end
end
