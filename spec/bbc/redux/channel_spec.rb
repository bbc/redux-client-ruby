require 'spec_helper'

describe BBC::Redux::Channel do

  let(:json)   { read_fixture 'channels.json'      }

  let(:mapper) { BBC::Redux::Serializers::Channels }

  subject      { mapper.new([]).from_json(json)    }

  {

    # attr / method => expected_value
    'size'               => 8,
    'first.name'         => 'bbcone',
    'first.display_name' => 'BBC One',
    'first.category_id'  => 1,
    'first.sort_order'   => 1010,

  }.each_pair do |attribute, value|
    its(attribute) { should eq(value) }
  end

end
