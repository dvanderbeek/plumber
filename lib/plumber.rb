require "plumber/engine"
require "ransack"
require "maildown"
require "liquid"

module Plumber
  mattr_accessor :email_from
  self.email_from = "from@example.com"

  def self.configure
    yield self
  end
end
