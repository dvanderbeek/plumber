module Plumber
  class Entrance < ApplicationRecord
    belongs_to :campaign
    belongs_to :record, polymorphic: true
  end
end
