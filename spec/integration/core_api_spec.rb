require 'integration/integration_test_helpers'

describe BBC::Redux::Url do

  include IntegrationTestHelpers

  [:mpeg2, :mpeg4, :mp3, :flv, :h264_lo, :h264_hi , :dvbsubs].each do |method|
    describe "##{method}" do
      it "should create a correct url" do
        login_and do |user|
          key  = client.key("5286433008768041518", user.session)
          url  = BBC::Redux::Url.send(method, "5286433008768041518", key)
          code = Typhoeus::Request.head(url).code
          (code / 100).should_not == 4 # Not a 4XX error, anything else is likely OK
        end
      end
    end
  end

end

describe BBC::Redux::Client do

  include IntegrationTestHelpers

  describe "#login" do
    it "should return the correct user info" do
      login_and do |user|
        user.username.should == username
      end
    end
    it "should raise a user not found error with invalid username" do
      lambda { client.login("bad-username", "password") }.should raise_error BBC::Redux::Exceptions::UserNotFoundException
    end
    it "should raise a user not found error with invalid username" do
      lambda { client.login(username, "bad-password") }.should raise_error BBC::Redux::Exceptions::UserPasswordException
    end
  end

  describe "#content" do
    it "should return correct content info" do
      login_and do |user|
        content = client.content("5606393469443492993", user.session)
        content.title.should   == "British Olympic Dreams"
        content.channel.should == "bbcnews24"
        content.generated_frames?.should == true
        content.generated_flv?.should    == true
      end
    end
  end

  describe "#key" do
    it "should return correct key info" do
      login_and do |user|
        key = client.key("5404438094219104161", user.session)
        key.value.should =~ /^#{user.id}/
      end
    end
  end

  describe "#tv_schedule" do
    it "should return correct key info" do
      login_and do |user|
        schedule = client.tv_schedule(Time.gm(2010, 10, 10), user.session)
        schedule.size.should  == 191
        schedule.first.should == "5526262264585557507"
      end
    end
  end

end
