require_relative '../lib/calendar'

describe Calendar do
  # let(:calendar) { Calendar.new }

  # describe '#initialize' do
  #   it 'Checks Calendar instance' do
  #     expect(calendar).to be_an_instance_of(Calendar)
  #   end
  # end

  # describe '#authorize' do
  #   it 'Checks credentials return' do
  #     expect(calendar.authorize).to be_an_instance_of(Google::Auth::UserRefreshCredentials)
  #   end
  # end

  # describe '#list' do
  #   context 'Checks list of calendar' do
  #     it { expect(calendar.list).to include('events') }

  #     it { expect { calendar.list('primary') }.to raise_error(ArgumentError) }
  #   end
  # end

  # describe '#fetch' do
  #   context 'Checks list of events in a calendar' do
  #     it { expect(calendar.fetch('primary')).to include('events') }

  #     it { expect { calendar.fetch }.to raise_error(ArgumentError) }
  #   end
  # end
end
