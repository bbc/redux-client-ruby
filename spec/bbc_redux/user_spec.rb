require "spec_helper"

describe BBC::Redux::User do

  describe ".from_xml" do
    it "should build an object from an XML response" do
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
      xml_user = BBC::Redux::User.from_xml(xml)
      xml_user.id.should             == 1234
      xml_user.username.should       == "testuser"
      xml_user.email.should          == "test.user@example.com"
      xml_user.first_name.should     == "Test"
      xml_user.last_name.should      == "User"
      xml_user.session.token.should  == "some-token"
    end
  end

  def data
    @data ||= {
      :id         => 1234,
      :username   => "some-user",
      :first_name => "Some",
      :last_name  => "User",
      :email      => "some.user@example.com",
      :session    => BBC::Redux::Session.new("some-token")
    }
  end

  def user
    BBC::Redux::User.new data
  end

  [:id, :username, :first_name, :last_name, :email, :session].each do |attribute|
    it "should expose #{attribute}" do
      user.send(attribute).should == data[attribute]
    end
  end

end
