require 'uri'

module BBC
  class Redux
    module Url

      API_HOST = "http://api.bbcredux.com"
      WWW_HOST = "http://g.bbcredux.com"

      def self.login(username, password)
        encode API_HOST + "/user/login?username=#{username}&password=#{password}"
      end

      def self.logout(token)
        API_HOST + "/user/logout?token=#{token}"
      end

      def self.key(disk_reference, token)
        API_HOST + "/content/#{disk_reference}/key?token=#{token}"
      end

      def self.content(disk_reference, token)
        API_HOST + "/content/#{disk_reference}/data?token=#{token}"
      end

      def self.mpeg2(disk_reference, key)
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/original/#{disk_reference}_mpeg2.ts"
      end

      def self.mpeg4(disk_reference, key)
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/2m-mp4/#{disk_reference}_mpeg4.ts"
      end

      def self.mp3(disk_reference, key)
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/radio-mp3/#{disk_reference}.mp3"
      end

      def self.flv(disk_reference, key)
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/flash.flv"
      end

      def self.h264_lo(disk_reference, key)
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/#{disk_reference}-lo.mp4"
      end

      def self.h264_hi(disk_reference, key)
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/#{disk_reference}-hi.mp4"
      end

      def self.dvbsubs(disk_reference, key)
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/#{disk_reference}-dvbsubs.xml"
      end

      def self.tv_schedule(date)
        WWW_HOST + "/day/#{date.strftime("%Y-%m-%d")}"
      end

      def self.frames(disk_reference, minute, key)
        Url::WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/frame-270-#{'%05d' % (minute * 60)}-60.jpg"
      end

      def self.ping
        WWW_HOST
      end

      private

      def self.encode(url)
        if RUBY_VERSION.match("1.8") || url.encoding.name == "UTF-8"
          url = url.unpack("U*").map { |c| c.chr }.join # ASCII VERSION
        end
        URI.encode(url)
      end

    end
  end
end
