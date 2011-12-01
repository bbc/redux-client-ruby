describe BBC::Redux do
  describe "#login" do
    it "should login and return an instance with logged in user" do
      username = "the dude"
      password = "big lebowski"
      fake_redux = mock
      
      BBC::Redux::Client.stub_chain(:new, :login).and_return(fake_redux)
      BBC::Redux.login(username, password).user.should == fake_redux
    end
  end
  
  describe "#mpeg2_url" do
    it "should login and return an instance with logged in user" do
      username = "the dude"
      password = "big lebowski"
      
      fake_redux = mock('Fake Redux')
      fake_key = mock('Fake Key')
      
      BBC::Redux::Client.stub_chain(:new, :login).and_return(fake_redux)
      redux = BBC::Redux.login(username, password)
      
      redux.should_receive(:key).with('disk_reference').and_return(fake_key)
      BBC::Redux::Url.should_receive(:mpeg2).with('disk_reference', fake_key).and_return('http://g.bbcredux/disk_reference/1.mpeg2')
      
      redux.mpeg2_url('disk_reference').should == 'http://g.bbcredux/disk_reference/1.mpeg2'
    end
  end
end