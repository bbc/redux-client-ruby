require 'spec_helper'

describe BBC::Redux::Asset do

  let(:json)   { read_fixture 'asset.json'         }

  let(:asset)  { described_class.new               }

  let(:mapper) { BBC::Redux::Serializers::Asset    }

  subject      { mapper.new(asset).from_json(json) }

  {

    # attribute            => expected_value
    'channel.class'        => BBC::Redux::Channel,
    'channel.display_name' => 'CBeebies',
    'channel.name'         => 'cbeebies',
    'pcrid.class'          => BBC::Redux::Crid,
    'pcrid.content'        => 'crid://fp.bbc.co.uk/4CBRMV',
    'pcrid.description'    => 'DTG programme CRID',
    'pcrid.to_s'           => 'crid://fp.bbc.co.uk/4CBRMV',
    'pcrid.type'           => '0x31',
    'scrid.class'          => BBC::Redux::Crid,
    'scrid.content'        => 'crid://fp.bbc.co.uk/LYRJ9T',
    'scrid.description'    => 'DTG series CRID',
    'scrid.to_s'           => 'crid://fp.bbc.co.uk/LYRJ9T',
    'scrid.type'           => '0x32',
    :access_key            => '1-1397227462-ba632af7af1ad',
    :description           => 'Animated adventures of Pingu. [S]',
    :disk_reference        => '5966413090093319525',
    :duration              => 300,
    :key                   => BBC::Redux::Key.new('1-1397227462-ba632af7af1ad'),
    :name                  => 'Pingu',
    :reference             => '5966413090093319525',
    :start                 => DateTime.parse('2014-01-08 06:50:00 +0000'),
    :title                 => 'Pingu',
    :uuid                  => '26a141fc-8511-4fef-aa2b-af1d1de5a75a',

  }.each_pair do |attribute, value|
    its(attribute) { should eq(value) }
  end

  it 'should works' do
    p subject.to_json
  end

  BBC::Redux::MediaUrl::TEMPLATES.each do |type|
    describe "##{type}_url" do
      it 'returns url of the correct type using the asset reference and key' do
        url = subject.send(:"#{type}_url")
        expect(url.type).to eq(type)
        expect(url.identifier).to eq(subject.reference)
        expect(url.key).to eq(subject.key)
      end
    end
  end

end
