require_relative '../lib/bot'
require_relative '../lib/calendar'
require 'httparty'
require 'google/apis/calendar_v3'

describe Bot do
  let(:bot) { Bot.new }
  describe '#initialize' do
    context 'Checks Instance of Bot and if bot creates Channels' do
      it { expect(bot).to be_an_instance_of(Bot) }

      it { expect(bot.channels).to include({ String => Channel }) }
    end
  end

  describe '#request' do
    it 'Checks method request' do
      expect(bot.request('https://slack.com/api/conversations.list')).to be_an_instance_of(HTTParty::Response)
    end
  end

  describe '#chat_post_message' do
    it 'Checks methos chat_post_message' do
      expect { bot.chat_post_message('C01E4QK0A75', 'text', '1604795990.024300') }
        .to output(String).to_stdout
    end
  end

  describe '#reply_conversation' do
    it 'Checks conversation reply' do
      expect { bot.reply_conversation('C01E4QK0A75', '1604795990.024300') }
        .to output(String).to_stdout
    end
  end

  describe '#mentioned?' do
    it 'Checks if bot was mentioned' do
      expect(bot.mentioned?('U01EHE352Q1')).to be_equal(true)
    end
  end
end
