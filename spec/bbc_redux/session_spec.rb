require "spec_helper"

describe BBC::Redux::Session do

  def session
    BBC::Redux::Session.new("some-token")
  end

  it "should have a it's token exposed" do
    session.token.should == "some-token"
  end

  it "should have a it's created_at exposed" do
    sleep 0.1
    session.created_at.should < Time.now
  end

end