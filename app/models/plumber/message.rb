module Plumber
  class Message < ApplicationRecord
    has_many :campaign_messages
    has_many :campaigns, through: :campaign_messages
  end
end
