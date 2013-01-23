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
      client.logout(user.session)
    end

    def content(disk_reference)
      client.content(disk_reference, user.session)
    end

    def key(disk_reference)
      client.key(disk_reference, user.session)
    end

    def tv_schedule(date)
      client.tv_schedule(date, user.session)
    end

    def radio_schedule(date)
      client.radio_schedule(date, user.session)
    end

    def ping
      client.ping(user.session)
    end

    [:mpeg2,:mpeg4,:mp3,:flv,:h264_lo,:h264_hi,:dvbsubs].each do |url_method|
      define_method("#{url_method}_url".to_sym) do |disk_reference|
        BBC::Redux::Url.send(url_method, disk_reference, key(disk_reference))
      end
    end

  end
end
