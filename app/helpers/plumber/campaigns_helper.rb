module Plumber
  module CampaignsHelper
    def twelve_hour(hour)
      if hour == 0
        "Beginning of day"
      elsif hour == 24
        "End of day"
      elsif hour <= 12
        "#{hour}am"
      else
        "#{hour - 12}pm"
      end
    end
  end
end
