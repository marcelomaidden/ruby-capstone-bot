require 'httparty'

require_relative 'token'

class Bot
  include HTTParty
  extend Auth
  default_params token: show_token
end

puts Bot.get('https://slack.com/api/conversations.list')


