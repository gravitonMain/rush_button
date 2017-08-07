# RushButton

## Requirements

This gem uses packet-fu, which requires libpcap.

Install:

    $ sudo apt-get install libpcap-dev

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rush_button'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rush_button


## Usage

```
require "rush_button"
srv = RushButton::Server.new("INTERFACE")
srv.add("MA:CA:DD:RE:SS:!!") do
  puts "|#{Time.now}| ARGHHHHHHH!"
end
srv.start
```

Find Amazon Dash Button's MAC address:

    $ sudo bundle exec find_button INTERFACE

