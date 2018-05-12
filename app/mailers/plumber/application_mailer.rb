module Plumber
  class ApplicationMailer < ::ApplicationMailer
    default from: Plumber.email_from
    layout 'mailer'
  end
end
