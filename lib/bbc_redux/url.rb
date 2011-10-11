module BBC
  module Redux
    module Url

      API_HOST = "http://api.bbcredux.com"
      WWW_HOST = "http://g.bbcredux.com"

      def self.login(username, password)
        API_HOST + "/user/login?username=#{username}&password=#{password}"
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
        WWW_HOST + "/programme/#{disk_reference}/download/#{key.value}/2m-mp4/#{disk_reference}.mp3"
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

    end
  end
end
