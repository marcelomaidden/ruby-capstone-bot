require_relative '../lib/bot'

bot = Bot.new

public_channels = bot.public_channels

public_channels["channels"].each { |k, v| puts "#{k}:#{v}\n"}

puts bot.conversation_history('C01E4JG6LG2')