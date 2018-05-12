require "plumber/engine"
require "ransack"
require "maildown"
require "liquid"
require "bootstrap"
require "jquery-rails"
require "simple_form"
require "kaminari"
require "bootstrap4-kaminari-views"
require "kramdown"

module Plumber
  mattr_accessor :email_from
  self.email_from = "from@example.com"

  mattr_accessor :brand_link
  self.brand_link = "/admin"

  mattr_accessor :nav_partial

  def self.configure
    yield self
  end
end
