describe BBC::Redux do

  before do
    @fake_user = mock("fake user")
    @fake_key  = mock("fake key")
    @instance  = BBC::Redux.new(@fake_user)
  end

  def session_expectation
    @fake_user.should_receive(:session).and_return('session')
  end

  def key_expectation
    session_expectation
    @instance.client.should_receive(:key).with('disk_reference', 'session').and_return(@fake_key)
  end

  describe "#login" do
    it "should login and return an instance with logged in user" do
      BBC::Redux::Client.stub_chain(:new, :login).and_return(@fake_user)
      BBC::Redux.login("username", "password").user.should == @fake_user
    end
  end

  describe "#logout" do
    it "should logout using the instance's user session" do
      session_expectation
      @instance.client.should_receive(:logout).with('session')
      @instance.logout
    end
  end

  describe "#content" do
    it "should retreive content using disk reference and current user session" do
      session_expectation
      @instance.client.should_receive(:content).with('disk_reference', 'session').and_return(:content)
      @instance.content('disk_reference').should == :content
    end
  end

  describe "#key" do
    it "should create a valid key using disk reference and current user session" do
      key_expectation
      @instance.key('disk_reference').should == @fake_key
    end
  end

  describe "#tv_schedule" do
    it "should retreive schedule using date and current user session" do
      session_expectation
      @instance.client.should_receive(:tv_schedule).with('date_object', 'session').and_return(:schedule)
      @instance.tv_schedule('date_object').should == :schedule
    end
  end

  context "Url methods" do
    [:mpeg2,:mpeg4,:mp3,:flv,:h264_lo,:h264_hi,:dvbsubs].each do |url_method|
      it "should generate a #{url_method} url" do
        key_expectation
        BBC::Redux::Url.should_receive(url_method).with('disk_reference', @fake_key).and_return('http://some/url')
        @instance.send("#{url_method}_url".to_sym, 'disk_reference').should == 'http://some/url'
      end
    end
  end

end