require 'spec_helper'

describe BBC::Redux::Cookie do

  let(:token)  { '1111111-Yf9hnrYmSsmCcWVZ52rquLRoaeDJT9EA'         }
  let(:string) { "BBC_video=#{token}; domain=.bbcredux.com; path=/" }
  let(:client) { BBC::Redux::Client.new( :token => token )          }

  context 'initialized with string' do
    subject { described_class.new(string) }
    its('token')  { should eq(token)  }
    its('client') { should eq(client) }
    its('to_s')   { should eq(string) }
    its('string') { should eq(string) }

    context 'bad string' do
      it 'should raise error' do
        expect { described_class.new('foobar') }.to raise_error(ArgumentError)
      end
    end
  end

  context 'initialized with client' do
    subject { described_class.new(client) }
    its('client') { should eq(client) }
    its('token')  { should eq(token)  }
    its('to_s')   { should eq(string) }
    its('string') { should eq(string) }
  end

  context 'initialized with junk' do
    it 'should raise error' do
      expect { described_class.new(1234) }.to raise_error(ArgumentError)
    end
  end

  describe '.==' do
    it 'should be true when token is the same' do
      a = described_class.new(string)
      b = described_class.new(client)
      expect(a).to eq(b)
    end
  end

end
