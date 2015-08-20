require "yaml"
class Client
  attr_reader :keys, :auth
  def initialize
    @keys = YAML.load_file('app/lib/application.yml')
    account_sid = @keys['ACCOUNT_SID']
    auth_token = @keys['AUTH_TOKEN']
    @auth = Twilio::REST::Client.new(account_sid, auth_token)
  end
end
