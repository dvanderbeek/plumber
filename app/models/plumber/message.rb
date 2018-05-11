module Plumber
  class Message < ApplicationRecord
    belongs_to :campaign
    has_many :sent_messages
  end
end
