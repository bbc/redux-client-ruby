require 'spec_helper'

describe BBC::Redux::Client do

  let(:http_client) { double('http_client')                     }
  let(:token)       { 'SOME-TOKEN'                              }
  let(:instance)    {
    described_class.new(:token => token, :http => http_client)
  }

  shared_examples_for 'a json based http method' do
    let(:unknown_response)  { double('http_resp', :code => rand(200..399)) }

    let(:badjson_exception) { BBC::Redux::Client::JsonParseException         }
    let(:badjson_response)  { double('http_resp', :code => 200, :body => '') }

    let(:fivexx_exception) { BBC::Redux::Client::HttpException            }
    let(:fivexx_response)  { double('http_resp', :code => rand(500..505)) }

    let(:forbidden_exception) { BBC::Redux::Client::ForbiddenException }
    let(:forbidden_response)  { double('http_resp', :code => 403)      }

    it 'should raise forbidden exception when HTTP API returns 403' do
      expect(http_client).to receive(:post).and_return(forbidden_response)
      expect { subject }.to raise_exception(forbidden_exception)
    end

    it 'should raise and http exception when HTTP API returns 5XX' do
      expect(http_client).to receive(:post).and_return(fivexx_response)
      expect { subject }.to raise_exception(fivexx_exception)
    end

    it 'should raise a generic exception with an unknown http status' do
      expect(http_client).to receive(:post).and_return(unknown_response)
      expect { subject }.to raise_exception(StandardError)
    end

    it 'should raise a json parse error when backend returns junk' do
      expect(http_client).to receive(:post).and_return(badjson_response)
      expect { subject }.to raise_exception(badjson_exception)
    end
  end

  context 'initialized with username / password' do
    subject { described_class.new({
      :http => http_client, :username => 'foo', :password => 'bar'
    }) }

    it_behaves_like 'a json based http method'

    it 'connects to redux api to get token' do
      resp = double(:resp, :code => 200, :body => '{"token":"TOKEN"}')

      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/user/login', {
        :body           => {
          :username => 'foo',
          :password => 'bar',
          :token    => nil,
        },
        :followlocation => true
      }).and_return(resp)

      expect(subject.token).to eq("TOKEN")
    end
  end

  context 'initialized with token' do
    it 'should be ready to go' do
      expect(instance.token).to eq(token)
      expect(instance.http).to eq(http_client)
    end
  end

  context 'account is compromised' do

    subject do
      described_class.new({
        :http => http_client, :username => 'foo', :password => 'bar'
      })
    end

    it 'raises error' do

      resp = double(:resp, :code => 200, :body => '{"compromised": true}')

      expect(http_client).to receive(:post).and_return(resp)

      expect { subject }.to \
        raise_error(BBC::Redux::Client::AccountCompromisedException)
    end
  end

  context 'initialized with neither token or username / password' do
    it 'raises an error' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end

  describe '#asset' do
    subject { instance.asset(reference) }

    let(:resp)        {
      double(:http_resp, :code => 200, :body => read_fixture('asset.json'))
    }

    let(:reference)   { '5966413090093319525'                     }
    let(:uuid)        { '26a141fc-8511-4fef-aa2b-af1d1de5a75a'    }

    it_behaves_like 'a json based http method'

    it 'takes json from the backend HTTP API and generates an asset object' do
      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/asset/details', {
          :body           => { :reference => reference, :token => token },
          :followlocation => true,
        }).and_return(resp)

      expect(subject.class).to eq(BBC::Redux::Asset)
      expect(subject.name).to eq('Pingu')
      expect(subject.channel.name).to eq('cbeebies')
    end

    it 'works when given a UUID rather than a disk reference' do
      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/asset/details', {
          :body           => { :uuid => uuid, :token => token },
          :followlocation => true,
        }).and_return(resp)

      asset = instance.asset(uuid)

      expect(asset.class).to eq(BBC::Redux::Asset)
      expect(asset.name).to eq('Pingu')
      expect(asset.channel.name).to eq('cbeebies')
    end
  end

  describe '#channels' do
    subject { instance.channels }

    let(:resp)        {
      double(:http_resp, :code => 200, :body => read_fixture('channels.json'))
    }

    it_behaves_like 'a json based http method'

    it 'takes json from the backend HTTP API and generates list of channels' do
      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/asset/channel/available', {
          :body           => { :token => token },
          :followlocation => true,
        }).and_return(resp)

      expect(subject.size).to eq(8)
      expect(subject.first.class).to eq(BBC::Redux::Channel)
      expect(subject.first.name).to eq('bbcone')
    end

  end

  describe '#channel_categories' do
    subject { instance.channel_categories }

    let(:resp)        {
      double(:http_resp, :code => 200,
        :body => read_fixture('channel_categories.json')) }

    it_behaves_like 'a json based http method'

    it 'takes json from the backend HTTP API, generates list of categories' do
      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/asset/channel/categories', {
          :body           => { :token => token },
          :followlocation => true,
        }).and_return(resp)

      expect(subject.size).to eq(5)
      expect(subject.first.class).to eq(BBC::Redux::ChannelCategory)
      expect(subject.first.description).to eq('BBC TV')
    end

  end

  describe '#logout' do
    subject { instance.logout }

    let(:resp) { double(:http_resp, :code => 200, :body => '{}') }

    it_behaves_like 'a json based http method'

    it 'posts to logout endpoint' do
      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/user/logout', {
          :body           => { :token => token },
          :followlocation => true,
        }).and_return(resp)

      expect(subject).to eq(nil)
    end

  end

  describe '#search' do
    subject { instance.search }

    let(:resp)        {
      double(:resp, :code => 200, :body => read_fixture('search_results.json'))
    }
    it_behaves_like 'a json based http method'

    it 'passes params to backend HTTP API and generates results object' do
      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/asset/search', {
          :body           => {
            :q      => 'foo',
            :longer => '200',
            :token  => token,
            :true   => '1',
            :false  => '0',
          },
          :followlocation => true,
        }).and_return(resp)

      query   = { :q => 'foo', :longer => 200, :true => true, :false => false }

      results = instance.search( query )

      expect(results.class).to be(BBC::Redux::SearchResults)
      expect(results.query).to eq( query )
    end

    context 'channel object based parameters' do

      let(:bbcone) { BBC::Redux::Channel.new(:name => 'bbcone') }

      it 'formats them correctly' do
        expect(http_client).to \
          receive(:post).with('https://i.bbcredux.com/asset/search', {
            :body           => { :channel => 'bbcone', :token => token },
            :followlocation => true,
          }).and_return(resp)

        results = instance.search(:channel => bbcone)

        expect(results.class).to be(BBC::Redux::SearchResults)
      end

      it 'handles an array correctly' do
        url = 'https://i.bbcredux.com/asset/search?channel=bbcone&channel=bbctwo'

        expect(http_client).to \
          receive(:post).with(url, {
            :body           => { :token => token },
            :followlocation => true,
          }).and_return(resp)

        results = instance.search(:channel => [ bbcone, 'bbctwo' ])

        expect(results.class).to be(BBC::Redux::SearchResults)
      end
    end

    context 'date / time based parameters' do
      it 'formats them correctly' do
        [ Time.now, Date.today, DateTime.now ].each do |datey|
          formatted = datey.strftime('%Y-%m-%dT%H:%M:%S')

          expect(http_client).to \
            receive(:post).with('https://i.bbcredux.com/asset/search', {
              :body           => { :date => formatted, :token => token },
              :followlocation => true,
            }).and_return(resp)

          results = instance.search(:date => datey)

          expect(results.class).to be(BBC::Redux::SearchResults)
        end
      end
    end

  end

  describe '#user' do
    subject { instance.user }

    let(:resp)        {
      double(:http_resp, :code => 200, :body => read_fixture('user.json'))
    }

    it_behaves_like 'a json based http method'

    it 'takes json from the backend HTTP API and generates a user object' do
      expect(http_client).to \
        receive(:post).with('https://i.bbcredux.com/user/details', {
          :body           => { :token => token },
          :followlocation => true,
        }).and_return(resp)

      expect(subject.class).to eq(BBC::Redux::User)
      expect(subject.name).to eq('Jane Smith')
    end

  end

end
