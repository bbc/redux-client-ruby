require "spec_helper"

describe BBC::Redux::Key do

  def valid_key
    BBC::Redux::Key.new("some-value")
  end

  def expired_key
    key = valid_key
    key.instance_variable_set(:@created_at, Time.now - (60 * 60 * 25))
    key
  end

  it "should have a it's value exposed" do
    valid_key.value.should == "some-value"
  end

  it "should have a it's created_at exposed" do
    sleep 0.1
    valid_key.created_at.should < Time.now
  end

  it "should have a it's expires_at exposed" do
    valid_key.expires_at.should > Time.now + (60 * 60 * 23) # Looks about right
  end

  describe "#expired?" do
    it "should return true if key has expired" do
      expired_key.expired?.should == true
    end
    it "should return false if key has not expires" do
      valid_key.expired?.should == false
    end
  end

  describe "#valid?" do
    it "should return true if key has not expired" do
      valid_key.valid?.should == true
    end
    it "should return false if key has expired" do
      expired_key.valid?.should == false
    end
  end

end
