require_relative '../lib/bot'

bot = Bot.new

while(true) do
  bot.channels.each do |k, ch|  
    bot.conversation_history(k)
  end
end

