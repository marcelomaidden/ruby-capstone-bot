require_relative '../lib/bot'
require_relative '../lib/calendar'
require 'httparty'
require 'google/apis/calendar_v3'

describe Bot do
  context 'Checks bot connectivity with slack API' do
    it { expect(Bot.test_connectivity).to be_equal(true) }
  end

  context 'Expect bot instance without slack token to raise_error' do
    it { expect { Bot.new }.to raise_error(NoMethodError) }
  end
end
