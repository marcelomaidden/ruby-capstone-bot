require 'httparty'

require_relative 'token'

require_relative 'channel'

require_relative 'conversation'

require_relative 'calendar'

class Bot
  # HTTParty is used to request a url via web api
  include HTTParty
  # Auth module to retrieve token
  extend Auth

  # parameteres used by HTTParty
  default_params token: show_token

  attr_reader :channels, :info, :response

  def initialize
    @info = Bot.get('https://slack.com/api/users.list')['members'].select do |v|
      v['name'] == 'rubycapstoneproject'
    end[0]

    public_channels
  end

  def request(url, _query = nil)
    @response = Bot.get(url)
  end

  def chat_post_message(channel, text, time_stamp)
    result = Bot.post('https://slack.com/api/chat.postMessage',
                      body: { channel: channel, text: text, thread_ts: time_stamp })
    puts result
  end

  def reply_conversation(channel, time_stamp)
    # reply to a message when bot was mentioned
    chat_post_message(channel, 'Automatic reply', time_stamp)
  end

  def mentioned?(text)
    text.include? @info['id']
  end

  def conversation_answers(channel, time_stamp)
    # retrieve answers for this conversation
    answers = Bot.get('https://slack.com/api/conversations.replies', query: { channel: channel, ts: time_stamp })
    answers['messages'][0]['reply_users']&.include? @info['id']
  end

  def conversation_history(channel)
    history = Bot.get('https://slack.com/api/conversations.history', query: { channel: channel })

    messages = []

    messages = history['messages'] unless history['messages'].nil?

    messages.each do |m|
      conversation_answers(channel, m['ts'])
      reply_conversation(channel, m['ts']) if mentioned?(m['text']) && !conversation_answers(channel, m['ts'])

      # create a conversation object
      conversation = Conversation.new(m['type'], m['subtype'], m['ts'], m['user'], m['text'])

      # add to the channel
      @channels[channel].add_message(conversation)
    end
  end

  def public_channels
    # Add channels and after that messages that belongs to that channel
    @channels = {}
    request('https://slack.com/api/conversations.list')['channels'].each do |ch|
      @channels[ch['id']] = Channel.new(ch['id'], ch['name'], ch['topic'], ch['purpose'])
      conversation_history(ch['id'])
    end
  end
end

calendar = Calendar.new
calendar.fetch('primary')