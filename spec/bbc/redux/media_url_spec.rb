require 'spec_helper'

describe BBC::Redux::MediaUrl do

  BBC::Redux::MediaUrl::TEMPLATES.each do |type|
    it "should initialize correctly when given a the #{type} type" do
      expect { generate_url :type => type }.to_not raise_error
    end
  end

  it 'should not initialize when given an invalid transcode type' do
    expect { generate_url :type => :foobar }.to raise_error
  end

  describe '#end_point' do

    it 'allows includes the host' do
      BBC::Redux::MediaUrl::TEMPLATES.each do |type|
        url = generate_url :type => type
        expect(url.end_point).to match(/^https:\/\/i.bbcredux.com\/asset/)
      end
    end

    it 'allows you to specify an explicit filename' do
      BBC::Redux::MediaUrl::TEMPLATES.each do |type|
        url = generate_url :type => type
        expect(url.end_point('foobar.file')).to match(/foobar\.file$/)
      end
    end

    it 'has correct value when we\'re an dvbsubs url' do
      url = generate_url :type => :dvbsubs, :identifier => 'abc'
      expect(url.end_point).to \
        match(/\/asset\/media\/abc\/#{url.key.value}\/dvbsubs\/abc.xml$/)
    end

    it 'has correct value when we\'re an flv url'

    it 'has correct value when we\'re an h264_hi url' do
      url = generate_url :type => :h264_hi, :identifier => 'abc'
      expect(url.end_point).to \
        match(/\/asset\/media\/abc\/#{url.key.value}\/h264_mp4_hi_v1.1\/abc-h264lg.mp4$/)
    end

    it 'has correct value when we\'re an h264_lo url' do
      url = generate_url :type => :h264_lo, :identifier => 'abc'
      expect(url.end_point).to \
        match(/\/asset\/media\/abc\/#{url.key.value}\/h264_mp4_lo_v1.0\/abc-h264sm.mp4$/)
    end

    it 'has correct value when we\'re an mp3 url' do
      url = generate_url :type => :mp3, :identifier => 'abc'
      expect(url.end_point).to \
        match(/\/asset\/media\/abc\/#{url.key.value}\/MP3_v1.0\/abc.mp3$/)
    end

    it 'has correct value when we\'re a ts url' do
      url = generate_url :type => :ts, :identifier => 'abc'
      expect(url.end_point).to \
        match(/\/asset\/media\/abc\/#{url.key.value}\/ts\/abc.mpegts$/)
    end

    it 'has correct value when we\'re a ts_stripped url' do
      url = generate_url :type => :ts_stripped, :identifier => 'abc'
      expect(url.end_point).to \
        match(/\/asset\/media\/abc\/#{url.key.value}\/strip\/abc-stripped.mpegts$/)
    end
  end

  describe '#to_s' do
    it 'should be the same as #end_point' do
      url = generate_url
      expect(url.to_s).to eq(url.end_point)
    end
  end

  describe '#expires_at' do
    it 'should be the same as the key\'s expires at time' do
      time = Time.now
      expect(generate_url(:expires_at => time).expires_at.to_time.to_i).to \
        be(time.to_i)
    end
  end

  describe '#expired?' do
    it 'should be true when expires_at is in the past' do
      expect(generate_url(:expires_at => Time.now - 300).expired?).to be(true)
    end

    it 'should be false when expires_at is in the future' do
      expect(generate_url(:expires_at => Time.now + 300).expired?).to be(false)
    end
  end

  describe '#live?' do
    it 'should be false when expires_at is in the past' do
      expect(generate_url(:expires_at => Time.now - 300).live?).to be(false)
    end

    it 'should be true when expires_at is in the future' do
      expect(generate_url(:expires_at => Time.now + 300).live?).to be(true)
    end
  end

  describe '#ttl' do
    it 'should return the key\'s TLL in seconds' do
      expect(generate_url.ttl).to be_within(1).of(0)
    end
  end

  describe '#==' do
    it 'should be true if urls have same identifier, type and key' do
      expect(generate_url).to eq(generate_url)
    end

    it 'should be false if urls have different identifiers' do
      expect(generate_url).to_not eq(generate_url(:identifier => '54321'))
    end

    it 'should be false if urls have different types' do
      expect(generate_url).to_not eq(generate_url(:type => :dvbsubs))
    end

    it 'should be false if urls have different keys' do
      expect(generate_url).to_not eq(generate_url(:expires_at => Time.now - 10))
    end

    it 'should be false if other key is something else' do
      expect(generate_url).to_not eq(:something_else)
    end
  end

  private

  def generate_url(options = { })
    identifier = options[:identifier] || '12345'
    expires_at = options[:expires_at] || Time.now
    type       = options[:type] || :mp3
    described_class.new( identifier, type, generate_key(expires_at) )
  end

  def generate_key(expires_at = Time.now)
    BBC::Redux::Key.new "1-#{expires_at.to_i}-ba632af7af1adb6f96dbeceb83331ad6"
  end

end

