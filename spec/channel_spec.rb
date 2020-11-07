require_relative '../lib/channel'

describe Channel do
  let(:channel) { Channel.new(1, 'Test', 'topic', 'purpose')}

  describe '#initialize' do
    context 'Checks creation for an instance of Channel' do
      
      it { expect(channel).to be_an_instance_of(Channel)}

      it { expect(channel).not_to be_an_instance_of(Integer)}

      it { expect{channel.add_message('test')}.to change(channel, :messages).from([]).to(['test'])}

    end
  end
end