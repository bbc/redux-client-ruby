# encoding : utf-8

require "spec_helper"
require "ostruct"

describe BBC::Redux::Url do

  def key
    OpenStruct.new :value => "some-key-value"
  end

  def self.url_test(name, &block)
    describe ".#{name}" do
      it("should generate a correct #{name} url", &block)
    end
  end

  url_test :API_HOST do
    BBC::Redux::Url::API_HOST.should == "http://api.bbcredux.com"
  end

  url_test :WWW_HOST do
    BBC::Redux::Url::WWW_HOST.should == "http://g.bbcredux.com"
  end

  url_test :login do
    BBC::Redux::Url.login("myname", "mypass").should == BBC::Redux::Url::API_HOST+"/user/login?username=myname&password=mypass"
  end

  describe ".login" do
    it "should encode wierd characters in the URL" do
      BBC::Redux::Url.login("myname", "$£").should == BBC::Redux::Url::API_HOST+"/user/login?username=myname&password=$%A3"
    end
  end

  url_test :logout do
    BBC::Redux::Url.logout("some-token").should == BBC::Redux::Url::API_HOST+"/user/logout?token=some-token"
  end

  url_test :key do
    expected = BBC::Redux::Url::API_HOST+"/content/some-disk-reference/key?token=some-token"
    BBC::Redux::Url.key("some-disk-reference", "some-token").should == expected
  end

  url_test :content do
    expected = BBC::Redux::Url::API_HOST+"/content/some-disk-reference/data?token=some-token"
    BBC::Redux::Url.content("some-disk-reference", "some-token").should == expected
  end

  url_test :mpeg2 do
    expected = BBC::Redux::Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/original/some-disk-reference_mpeg2.ts"
    BBC::Redux::Url.mpeg2("some-disk-reference", key).should == expected
  end

  url_test :mpeg4 do
    expected = BBC::Redux::Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/2m-mp4/some-disk-reference_mpeg4.ts"
    BBC::Redux::Url.mpeg4("some-disk-reference", key).should == expected
  end

  url_test :mp3 do
    expected = BBC::Redux::Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/radio-mp3/some-disk-reference.mp3"
    BBC::Redux::Url.mp3("some-disk-reference", key).should == expected
  end

  url_test :flv do
    expected = BBC::Redux::Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/flash.flv"
    BBC::Redux::Url.flv("some-disk-reference", key).should == expected
  end

  url_test :h264_lo do
    expected = BBC::Redux::Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/some-disk-reference-lo.mp4"
    BBC::Redux::Url.h264_lo("some-disk-reference", key).should == expected
  end

  url_test :h264_hi do
    expected = BBC::Redux::Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/some-disk-reference-hi.mp4"
    BBC::Redux::Url.h264_hi("some-disk-reference", key).should == expected
  end

  url_test :dvbsubs do
    expected = BBC::Redux::Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/some-disk-reference-dvbsubs.xml"
    BBC::Redux::Url.dvbsubs("some-disk-reference", key).should == expected
  end

  url_test :tv_schedule do
    expected = BBC::Redux::Url::WWW_HOST + "/day/2010-10-10"
    BBC::Redux::Url.tv_schedule(Time.gm(2010, 10, 10)).should == expected
  end

end