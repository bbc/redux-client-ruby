require "spec_helper"
require "ostruct"

describe BBC::Redux::Client do

  def client
    @client ||= BBC::Redux::Client.new
  end

  def fake_session()
    OpenStruct.new(:token => "fake-token")
  end

  def fake_response(code, body = "")
    OpenStruct.new(:code => code, :body => body)
  end


  describe "#login" do
    it "should parse an OK response correctly" do
      xml = %Q{<?xml version="1.0" encoding="UTF-8" ?>
      <response>
        <user>
          <token>some-token</token>
          <id>1234</id>
          <username>testuser</username>
          <email>test.user@example.com</email>
          <first_name>Test</first_name>
          <last_name>User</last_name>
        </user>
      </response>
      }
      client.stub!(:get).and_return(fake_response(200, xml))
      client.login("username", "password").username.should == "testuser"
    end
    it "should raise user not found exception with invalid user name" do
      client.stub!(:get).and_return(fake_response(404))
      lambda { client.login("username", "password") }.should raise_error BBC::Redux::Exceptions::UserNotFoundException
    end
    it "should raise user incorrect password exception with invalid password" do
      client.stub!(:get).and_return(fake_response(403))
      lambda { client.login("username", "password") }.should raise_error BBC::Redux::Exceptions::UserPasswordException
    end
    it "should raise a client http exception with a bad response" do
      client.stub!(:get).and_return(fake_response(500))
      lambda { client.login("username", "password") }.should raise_error BBC::Redux::Exceptions::ClientHttpException
    end
  end

  describe "#logout" do
    it "should parse an OK response correctly" do
      client.stub!(:get).and_return(fake_response(200))
      client.logout(fake_session)
    end
    it "should raise a client http exception with a bad response" do
      client.stub!(:get).and_return(fake_response(500))
      lambda { client.logout(fake_session) }.should raise_error BBC::Redux::Exceptions::ClientHttpException
    end
  end

  describe "#key" do
    it "should parse an OK response correctly" do
      xml = %Q{<?xml version="1.0" encoding="UTF-8" ?>
      <response>
        <programme>
          <key>some-value</key>
        </programme>
      </response>
      }
      client.stub!(:get).and_return(fake_response(200, xml))
      client.key("some-disk-reference", fake_session).value.should == "some-value"
    end
    it "should raise a content not found exception when given a non existent disk reference" do
      client.stub!(:get).and_return(fake_response(404))
      lambda { client.key("some-disk-reference", fake_session) }.should raise_error BBC::Redux::Exceptions::ContentNotFoundException
    end
    it "should raise a session invalid exception when given an an invalid session object" do
      client.stub!(:get).and_return(fake_response(403))
      lambda { client.key("some-disk-reference", fake_session) }.should raise_error BBC::Redux::Exceptions::SessionInvalidException
    end
    it "should raise a client http exception with a bad response" do
      client.stub!(:get).and_return(fake_response(500))
      lambda { client.key("some-disk-reference", fake_session) }.should raise_error BBC::Redux::Exceptions::ClientHttpException
    end
  end

  describe "#content" do
    it "should parse an OK response correctly" do
      xml = %Q{<?xml version="1.0" encoding="UTF-8" ?>
      <response>
        <programme frames="1">
          <time>18:55:00</time>
          <date>2010-12-25</date>
          <channel>bbctwo</channel>
          <reference>5554695377586026009</reference>
          <duration>3600</duration>
          <unixtime>1293303300</unixtime>
          <description>Some description</description>
          <series_crid>fp.bbc.co.uk/KRYRHR</series_crid>
          <programme_crid>fp.bbc.co.uk/1RE93D</programme_crid>
          <name>Top Gear</name>
          <key>some-key's-value</key>
        </programme>
      </response>
      }
      client.stub!(:get).and_return(fake_response(200, xml))
      client.content("some-disk-reference", fake_session).channel.should == "bbctwo"
    end
    it "should raise a content not found exception when given a non existent disk reference" do
      client.stub!(:get).and_return(fake_response(404))
      lambda { client.content("some-disk-reference", fake_session) }.should raise_error BBC::Redux::Exceptions::ContentNotFoundException
    end
    it "should raise a session invalid exception when given an an invalid session object" do
      client.stub!(:get).and_return(fake_response(403))
      lambda { client.content("some-disk-reference", fake_session) }.should raise_error BBC::Redux::Exceptions::SessionInvalidException
    end
    it "should raise a client http exception with a bad response" do
      client.stub!(:get).and_return(fake_response(500))
      lambda { client.content("some-disk-reference", fake_session) }.should raise_error BBC::Redux::Exceptions::ClientHttpException
    end
  end

end