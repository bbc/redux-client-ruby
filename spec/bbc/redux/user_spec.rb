require 'spec_helper'

describe BBC::Redux::User do

  let(:json)   { read_fixture 'user.json'         }

  let(:user)   { described_class.new              }

  let(:mapper) { BBC::Redux::Serializers::User    }

  subject      { mapper.new(user).from_json(json) }

  {

    # attribute_name    => expected_value
    :admin              => false,
    :admin?             => false,
    :can_invite         => false,
    :can_invite?        => false,
    :created            => DateTime.parse('2008-01-01 01:01:01 +0000'),
    :department         => 'My Department',
    :division           => 'My Division',
    :email              => 'mail@example.com',
    :first_name         => 'Jane',
    :id                 => 1234,
    :last_name          => 'Smith',
    :legal_accepted     => false,
    :legal_html         => '<h1>Action Required</h1>',
    :must_sign_terms?   => true,
    :name               => 'Jane Smith',
    :permitted_services => [ 'uk.bbc.radio', 'uk.bbc.tv' ],
    :username           => 'jsmith',
    :uuid               => 'eac522fe-313a-453e-97b0-d33e6fd50c62'

  }.each_pair do |attribute, value|
    its(attribute) { should eq(value) }
  end

end
