require 'spec_helper'

describe BBC::Redux::ChannelCategory do

  let(:json)   { read_fixture 'channel_categories.json'      }

  let(:mapper) { BBC::Redux::Serializers::ChannelCategories  }

  subject      { mapper.new([]).from_json(json)              }

  {

    # attr / method     => expected_value
    'size'              => 5,
    'first.description' => 'BBC TV',
    'first.id'          => 1,
    'first.priority'    => 1000,

  }.each_pair do |attribute, value|
    its(attribute) { should eq(value) }
  end

end
