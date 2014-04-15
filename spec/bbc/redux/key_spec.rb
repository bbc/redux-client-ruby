require 'spec_helper'

describe BBC::Redux::Key do

  let(:value)  { '1-1397227462-ba632af7af1adb6f96dbeceb83331ad6' }

  subject      { described_class.new(value)                      }

  {

    # attr/method => expected_value
    :value        => '1-1397227462-ba632af7af1adb6f96dbeceb83331ad6',
    :to_s         => '1-1397227462-ba632af7af1adb6f96dbeceb83331ad6',
    :expires_at   => DateTime.parse('2014-04-11 15:44:22 +0100'),

  }.each_pair do |attribute, value|
    its(attribute) { should eq(value) }
  end

  describe '#expired?' do
    it 'should be true when expires_at is in the past' do
      expect(generate_key(Time.now - 300).expired?).to be(true)
    end

    it 'should be false when expires_at is in the future' do
      expect(generate_key(Time.now + 300).expired?).to be(false)
    end
  end

  describe '#live?' do
    it 'should be false when expires_at is in the past' do
      expect(generate_key(Time.now - 300).live?).to be(false)
    end

    it 'should be true when expires_at is in the future' do
      expect(generate_key(Time.now + 300).live?).to be(true)
    end
  end

  describe '#ttl' do
    it 'should return the key\'s TLL in seconds' do
      expect(generate_key.ttl).to be_within(1).of(0)
    end
  end

  describe '#==' do
    it 'should be true if keys have same values' do
      expect(subject).to eq(described_class.new(value))
    end

    it 'should be false if keys have different values' do
      expect(subject).to_not eq(generate_key)
    end

    it 'should be false if other key is something else' do
      expect(subject).to_not eq(:something_else)
    end
  end

  private

  def generate_key(expires_at = Time.now)
    described_class.new "1-#{expires_at.to_i}-ba632af7af1adb6f96dbeceb83331ad6"
  end

end
