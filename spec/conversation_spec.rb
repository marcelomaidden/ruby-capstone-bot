require_relative '../lib/conversation.rb'

describe Conversation do
  let(:conversation) { Conversation.new('type', 'subtype', 'time_stamp', 'user', 'text') }
  let(:conversation2) { Conversation.new('type', 'subtype', 'time_stamp', 'user') }

  describe '#initialize' do
    context 'Checks if initialize returns a Conversation instance' do
      
      it { expect(conversation).to be_an_instance_of(Conversation) }

      it { expect{conversation2}.to raise_error(ArgumentError) }

    end
  end
end