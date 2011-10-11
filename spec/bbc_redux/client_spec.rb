require "spec_helper"

describe BBC::Redux::Client do

  describe "#login" do
    it "should parse an OK response correctly" do
      pending
    end
    it "should raise user not found exception with invalid user name" do
      pending
    end
    it "should raise user inccorect password exception with invalid password" do
      pending
    end
    it "should raise a client http exception with a bad response" do
      pending
    end
  end

  describe "#logout" do
    it "should parse an OK response correctly" do
      pending
    end
    it "should raise a client http exception with a bad response" do
      pending
    end
  end

  describe "#key" do
    it "should parse an OK response correctly" do
      pending
    end
    it "should raise a content not found exception when given a non existent disk reference" do
      pending
    end
    it "should raise a session invalid exception when given an an invalid session object" do
      pending
    end
    it "should raise a client http exception with a bad response" do
      pending
    end
  end

  describe "#content" do
    it "should parse an OK response correctly" do
      pending
    end
    it "should raise a content not found exception when given a non existent disk reference" do
      pending
    end
    it "should raise a session invalid exception when given an an invalid session object" do
      pending
    end
    it "should raise a client http exception with a bad response" do
      pending
    end
  end

  describe "#get" do
    it "should return a response object with OK response" do
      pending
    end
    it "should raise a client http exception with a bad response" do
      pending
    end
  end

end