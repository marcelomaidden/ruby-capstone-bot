require 'httparty'

require_relative 'token'

require_relative 'channel'

require_relative 'conversation'

class Bot
  # HTTParty is used to request a url via web api
  include HTTParty
  # Auth module to retrieve token
  extend Auth
  
  # parameteres used by HTTParty
  default_params token: show_token

  attr_reader :channels

  def initialize
    public_channels
  end

  def request(url, query=nil)
    @response = Bot.get(url)
  end

  def response
    @response
  end

  def conversation_history(channel)
    return Bot.get('https://slack.com/api/conversations.history', query: {channel: channel})
  end

  def public_channels
    @channels = []
    request('https://slack.com/api/conversations.list')["channels"].each do
      |ch|
      @channels << Channel.new(ch['id'], ch['name'], ch['topic'], ch['purpose'])
    end
  end
end



