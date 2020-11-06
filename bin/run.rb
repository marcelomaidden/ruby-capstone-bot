require_relative '../lib/bot'

bot = Bot.new

loop do
  bot.channels.each do |k, _ch|
    bot.conversation_history(k)
  end
end
