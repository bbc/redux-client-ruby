require 'spec_helper'


class BBC::Redux

  class HttpClient
    include Http
  end

  describe Http do
    context ".head_page" do
      it 'should raise ClientHttpException if response is not successful' do
        fake_token = 'token'
        url = 'http://g.bbcredux.com'
        fake_response = Typhoeus::Response.new(:code => 400)
        Typhoeus::Request.stub!(:head).with(url, {:headers => {:Cookie => "BBC_video=#{fake_token}"} } ).and_return(fake_response)

        lambda{ HttpClient.new.head_page(url, fake_token) }.should raise_exception(Exceptions::ClientHttpException)
      end
    end
  end
end
