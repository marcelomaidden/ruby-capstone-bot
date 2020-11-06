require 'httparty'

require_relative 'token'

class Bot
  # HTTParty is used to request a url via web api
  include HTTParty
  # Auth module to retrieve token
  extend Auth
  
  # parameteres used by HTTParty
  default_params token: show_token
  format :json

  def request(url, query=nil)
    @response = Bot.get(url)
  end

  def response
    @response
  end

  def public_channels
    return request('https://slack.com/api/conversations.list')
  end

  def conversation_history(channel)
    return Bot.get('https://slack.com/api/conversations.history', query: {channel: channel})
  end
end



