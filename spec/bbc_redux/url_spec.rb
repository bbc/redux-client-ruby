# encoding : utf-8

require "spec_helper"
require "ostruct"

class BBC::Redux

  describe Url do

    def key
      OpenStruct.new :value => "some-key-value"
    end

    def self.url_test(name, &block)
      describe ".#{name}" do
        it("should generate a correct #{name} url", &block)
      end
    end

    url_test :API_HOST do
      Url::API_HOST.should == "http://api.bbcredux.com"
    end

    url_test :WWW_HOST do
      Url::WWW_HOST.should == "https://g.bbcredux.com"
    end

    url_test :login do
      Url.login("myname", "mypass").should == Url::API_HOST+"/user/login?username=myname&password=mypass"
    end

    describe ".login" do
      it "should encode wierd characters in the URL" do
        Url.login("myname", "$£").should == Url::API_HOST+"/user/login?username=myname&password=$%A3"
      end
    end

    url_test :logout do
      Url.logout("some-token").should == Url::API_HOST+"/user/logout?token=some-token"
    end

    url_test :key do
      expected = Url::API_HOST+"/content/some-disk-reference/key?token=some-token"
      Url.key("some-disk-reference", "some-token").should == expected
    end

    url_test :content do
      expected = Url::API_HOST+"/content/some-disk-reference/data?token=some-token"
      Url.content("some-disk-reference", "some-token").should == expected
    end

    url_test :mpeg2 do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/original/some-disk-reference_mpeg2.ts"
      Url.mpeg2("some-disk-reference", key).should == expected
      Url.mpeg2("some-disk-reference", key, nil).should == expected
      Url.mpeg2("some-disk-reference", key, 'foobar').should == expected.gsub('some-disk-reference_mpeg2', 'foobar')
    end

    url_test :mpeg4 do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/2m-mp4/some-disk-reference_mpeg4.ts"
      Url.mpeg4("some-disk-reference", key).should == expected
      Url.mpeg4("some-disk-reference", key, 'foobar').should == expected.gsub('some-disk-reference_mpeg4', 'foobar')
    end

    url_test :mp3 do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/radio-mp3/some-disk-reference.mp3"
      Url.mp3("some-disk-reference", key).should == expected
      Url.mp3("some-disk-reference", key, 'foobar').should == expected.gsub('some-disk-reference.mp3', 'foobar.mp3')
    end

    url_test :flv do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/flash.flv"
      Url.flv("some-disk-reference", key).should == expected
    end

    url_test :h264_lo do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/some-disk-reference-lo.mp4"
      Url.h264_lo("some-disk-reference", key).should == expected
      Url.h264_lo("some-disk-reference", key, 'foobar').should == expected.gsub('some-disk-reference-lo', 'foobar')
    end

    url_test :h264_hi do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/some-disk-reference-hi.mp4"
      Url.h264_hi("some-disk-reference", key).should == expected
      Url.h264_hi("some-disk-reference", key, 'foobar').should == expected.gsub('some-disk-reference-hi', 'foobar')
    end

    url_test :dvbsubs do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/some-disk-reference-dvbsubs.xml"
      Url.dvbsubs("some-disk-reference", key).should == expected
      Url.dvbsubs("some-disk-reference", key, 'foobar').should == expected.gsub('some-disk-reference-dvbsubs', 'foobar')
    end

    url_test :tv_schedule do
      expected = Url::WWW_HOST + "/day/2010-10-10"
      Url.tv_schedule(Time.gm(2010, 10, 10)).should == expected
    end

    url_test :radio_schedule do
      expected = Url::WWW_HOST + "/day/radio-2010-10-10"
      Url.radio_schedule(Time.gm(2010, 10, 10)).should == expected
    end

    url_test :frames do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/frame-270-00600-60.jpg"
      Url.frames("some-disk-reference", 10, key).should == expected
    end

    url_test :montage do
      expected = Url::WWW_HOST + "/programme/some-disk-reference/download/" + key.value + "/frame-180-all.jpg"
      Url.montage("some-disk-reference", key).should == expected
    end

    url_test :ping do
      expected = Url::WWW_HOST
      Url.ping.should == expected
    end
  end

end
