require "spec_helper"

describe BBC::Redux::User do

  describe ".from_xml" do
    it "should build an object from an XML response" do
      pending
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
