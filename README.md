# Plumber
Plumber lets you define drip email campaigns and provides a dashboard to view the campaings, messages, and sent emails.

## Usage

* Provide a `CampaignDefinition` class that tells the gem about your campaigns and messages. In this example, we are pulling from an CMS with a JSON API, but you could also just define everything as an array of Campaign objects with nested Message objects in this file. If you do that, your `.get_message` and `.get_campaign` methods would just have to find the correct instance using Ruby to search through all the Campaigns.

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

* Campaigns have a `record_class` setting which should be an ActiveRecord model that provides an `#email` method and responds to `#to_h` so that we can populate your Liquid message templates.

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

## Example Campaign Definition without CMS

```ruby
module Plumber
  class CampaignDefinition
    def self.get_message(id)
      list_campaigns.map(&:messages).flatten.find { |e| e.id == id.to_i }
    end

    def self.get_campaign(id)
      list_campaigns.find { |e| e.id == id.to_i }
    end

    def self.list_campaigns
        Campaign.new(
          id: 1,
          title: "Welcome",
          record_class: "User",
          delay_column: "created_at",
          start_sending: 9, # 9am
          stop_sending: 17, # 5pm
          filter: {
            status_eq: "open",
            sign_in_count_lteq: 3
          },
          messages: [
            Message.new(
              id: 2,
              subject: "Welcome to Our Site",
              delay: 0,
              active: true,
              template: "Welcome to our site {{ user.name }}!! You can use Liquid markup in your templates."
            ),
            Message.new(
              id: 3,
              subject: "Following up!",
              delay: 3,
              active: true,
              template: "Some other email getting you to do something!"
            )
          ]
        ),
      ]
    end
  end
end
```
