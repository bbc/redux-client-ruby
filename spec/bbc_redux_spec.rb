describe BBC::Redux do
  describe "#login" do
    it "should login and return an instance with logged in user" do
      username = "the dude"
      password = "big lebowski"
      fake_user = mock
      
      BBC::Redux::Client.stub_chain(:new, :login).and_return(fake_user)
      BBC::Redux.login(username, password).user.should == fake_user
    end
  end
  
  describe "#key" do
    it "should create a valid key using disk reference and a user session" do
      username = "the dude"
      password = "big lebowski"
      
      fake_user = mock('Fake User')
      fake_key = mock('Fake Key')
      
      BBC::Redux::Client.stub_chain(:new, :login).and_return(fake_user)
      redux = BBC::Redux.login(username, password)
      
      fake_user.should_receive(:session).and_return('session')
      redux.client.should_receive(:key).with('disk_reference', 'session').and_return(fake_key)
      
      redux.key('disk_reference').should == fake_key
    end
  end
  
  describe "#mpeg2_url" do
    it "should login and return an instance with logged in user" do
      username = "the dude"
      password = "big lebowski"
      
      fake_user = mock('Fake User')
      fake_key = mock('Fake Key')
      
      BBC::Redux::Client.stub_chain(:new, :login).and_return(fake_user)
      redux = BBC::Redux.login(username, password)
      
      redux.should_receive(:key).with('disk_reference').and_return(fake_key)
      BBC::Redux::Url.should_receive(:mpeg2).with('disk_reference', fake_key).and_return('http://g.bbcredux/disk_reference/1.mpeg2')
      
      redux.mpeg2_url('disk_reference').should == 'http://g.bbcredux/disk_reference/1.mpeg2'
    end
  end
end