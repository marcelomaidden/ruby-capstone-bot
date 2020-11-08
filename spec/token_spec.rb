require_relative '../lib/token'

describe Auth do
  describe '#show_token' do
    context 'Checks if method show_token return a token' do
      it { expect { Auth.show_token }.to output(String).to_stdout }

      it { expect { Auth.show_token }.not_to raise_error }
    end
  end
end
