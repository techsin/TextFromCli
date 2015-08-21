require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

Dir["app/models/*.rb"].each {|f| require f}
Dir["app/data_fetchers/*.rb"].each {|f| require f}
Dir["app/runners/*.rb"].each {|f| require f}

require 'twilio-ruby'
require 'yaml'
require "pry"
require "json"
require "open-uri"
