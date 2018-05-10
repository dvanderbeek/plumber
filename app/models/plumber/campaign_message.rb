module Plumber
  class CampaignMessage < ApplicationRecord
    belongs_to :message
    belongs_to :campaign
    has_many :sent_messages
  end
end
