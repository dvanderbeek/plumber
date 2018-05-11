module Plumber
  class ApplicationMailer < ActionMailer::Base
    default from: Plumber.email_from
    layout 'mailer'
  end
end
