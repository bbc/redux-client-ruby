require 'spec_helper'

describe BBC::Redux::SearchResults do

  let(:json)   { read_fixture 'search_results.json'      }

  let(:mapper) { BBC::Redux::Serializers::SearchResults  }

  let(:object) { described_class.new                     }

  subject      { mapper.new(object).from_json(json)      }

  {

    # attr / method => expected_value
    'created_at'     => DateTime.parse('2014-04-15 17:35:42 +0100'),
    'offset'         => 10,
    'query_time'     => 0.166,
    'total'          => 25435,
    'total_returned' => 10,

  }.each_pair do |attribute, value|
    its(attribute) { should eq(value) }
  end

  describe '#assets' do
    it 'should represent the assets listed in the results' do
      expect(subject.assets.size).to be(10)
      expect(subject.assets.first.name).to eq("Bargain Hunt")

      expect(subject.assets.first.uuid).to \
        eq('87ba761a-2fb7-4437-a7bd-f358269e537c')

      expect(subject.assets.first.description).to \
        eq('Edinburgh: Bargain Hunt visits Scotland\'s capital')

      expect(subject.assets.first.key).to \
        eq(BBC::Redux::Key.new('1-1397666142-936014a77cbe46ada46c2e114676a86b'))


      expect(subject.assets.first.start).to \
        eq(DateTime.parse('2014-04-15 12:15:00 +0100'))

      expect(subject.assets.first.channel.name).to eq('bbcone')
      expect(subject.assets.first.duration).to eq(2700)
      expect(subject.assets.first.reference).to eq('6002476641954360370')

    end
  end

  describe '#has_more?' do
    it 'should be false when offset + total_returned >= total' do
      results = described_class.new({
        :offset => 20, :total_returned => 10, :total => 30
      })

      expect(results.has_more?).to be(false)
    end

    it 'should be true when offset + total_returned < total' do
      results = described_class.new({
        :offset => 20, :total_returned => 10, :total => 40
      })

      expect(results.has_more?).to be(true)
    end
  end

  describe '#next_query' do
    it 'should be false when offset + total_returned >= total' do
      results = described_class.new({
        :offset => 20, :total_returned => 10, :total => 30
      })

      expect(results.next_query).to be(nil)
    end

    it 'is otherwise the curent query with offset raised by limit' do

      results = described_class.new({
        :query          => { :limit => 10, :offset => 20, :untouched => :foo },
        :offset         => 20,
        :total          => 40,
        :total_returned => 10,
      })

      expect(results.next_query[:limit]).to  eq(10)
      expect(results.next_query[:offset]).to eq(30)
      expect(results.next_query[:untouched]).to eq(:foo)

    end
  end

end
