# Plumber
Short description and motivation.

## Usage

* Provide a CampaignDefinition class that tells the gem about your campaigns and messages. In this example, we are pulling from an CMS with a JSON API, but you could also just define everything as an array of Campaign objects with nested Message objects in this file.

```ruby
module Plumber
  class CampaignDefinition
    def self.list_campaigns
      response = HTTParty.get(
        "#{Segment::Scopes.base_uri}/campaigns",
        headers: { "authorization" => "Bearer #{Segment::Scopes.api_key}" }
      )
      response["data"].map { |attrs| Campaign.new(attrs) }
    rescue
      []
    end

    def self.get_message(id)
      response = HTTParty.get(
        "#{Segment::Scopes.base_uri}/messages/#{id}",
        headers: { "authorization" => "Bearer #{Segment::Scopes.api_key}" }
      )
      Message.new(response["data"])
    rescue
      nil
    end

    def self.get_campaign(id)
      response = HTTParty.get(
        "#{Segment::Scopes.base_uri}/campaigns/#{id}",
        headers: { "authorization" => "Bearer #{Segment::Scopes.api_key}" }
      )
      Campaign.new(response["data"])
    rescue
      nil
    end
  end
end
```

* Run a scheduled job to periodically check for new records that should get an email by running `Plumber::Campaign.send!`

## Installation
Add this line to your application's Gemfile:

```ruby
gem "plumber", github: "dvanderbeek/plumber", branch: "master"
```

And then execute:
```bash
$ bundle
```

Then mount the engine:
```ruby
mount Plumber::Engine, at: '/drip'
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
