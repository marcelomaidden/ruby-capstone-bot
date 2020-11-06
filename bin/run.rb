require_relative '../lib/bot'

bot = Bot.new

bot.channels.each do |k, ch|  
  puts k
  ch.messages.each do |m|
    puts m.text
    bot.chat_post_message(k, "Create message on #{k}")
  end
end
