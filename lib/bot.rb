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

  def chat_post_message(channel, text)
    result = Bot.post('https://slack.com/api/chat.postMessage', body: {channel: channel, text: text, username: 'bot'})
    puts result
  end

  def conversation_history(channel)
    history = Bot.get('https://slack.com/api/conversations.history', query: {channel: channel})

    messages = []

    messages = history["messages"] unless history["messages"].nil?

    messages.each do
      |m| 
      conversation = Conversation.new(m['type'], m['subtype'], m['ts'], m['user'], m['text'])
      @channels[channel].add_message(conversation)
    end
  end

  def public_channels
    # Add channels and after that messages that belongs to that channel
    @channels = Hash.new
    request('https://slack.com/api/conversations.list')["channels"].each do
      |ch|
      @channels[ch['id']] = Channel.new(ch['id'], ch['name'], ch['topic'], ch['purpose'])
      conversation_history(ch['id'])
    end
  end
end



