require "nokogiri"

require "bbc_redux/client"
require "bbc_redux/content"
require "bbc_redux/key"
require "bbc_redux/schedule"
require "bbc_redux/session"
require "bbc_redux/url"
require "bbc_redux/user"

module BBC
  class Redux
    attr_reader :client, :user
    
    def self.login(username, password)
      user = BBC::Redux::Client.new.login(username, password)
      self.new(user)
    end
    
    def initialize(user)
      @user = user
      @client = BBC::Redux::Client.new
    end
    
    def logout
      client.logout(user)
    end
    
    def key(disk_reference)
      client.key(disk_reference, user.session)
    end
    
    def mpeg2_url(disk_reference)
      BBC::Redux::Url.mpeg2(disk_reference, key(disk_reference))
    end
  end
end