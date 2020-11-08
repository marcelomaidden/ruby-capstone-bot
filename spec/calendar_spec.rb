require_relative '../lib/calendar'

describe Calendar do
  let(:calendar) { Calendar.new }

  describe '#initialize' do
    it 'Checks Calendar error when no credentials are provided' do
      expect { calendar }.to raise_error(Errno::ENOENT)
    end
  end
end
