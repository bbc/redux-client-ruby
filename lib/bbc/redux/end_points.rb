module BBC
  module Redux

    # @private
    module EndPoints

      HOST = 'https://i.bbcredux.com'

      # Make dvb subs media file end point
      # @param id    [String] asset identifier
      # @param key   [String] string value of a valid access key
      # @param fname [String] template for the file name
      # @return [String] The end point
      def self.dvbsubs(id, key, fname = nil)
        HOST + "/asset/media/#{id}/#{key}/dvbsubs/#{(fname || '%s.xml') % id}"
      end

      # Make mp3 media file end point
      # @param id    [String] asset identifier
      # @param key   [String] string value of a valid access key
      # @param fname [String] template for the file name
      # @return [String] The end point
      def self.mp3(id, key, fname = nil)
        HOST + "/asset/media/#{id}/#{key}/MP3_v1.0/#{(fname || '%s.mp3') % id}"
      end

      # Make h264_hi media file end point
      # @param id    [String] asset identifier
      # @param key   [String] string value of a valid access key
      # @param fname [String] template for the file name
      # @return [String] The end point
      def self.h264_hi(id, key, fname = nil)
        HOST + "/asset/media/#{id}/#{key}/h264_mp4_hi_v1.1/" \
             + (fname || '%s-h264lg.mp4') % id
      end

      # Make h264_lo media file end point
      # @param id    [String] asset identifier
      # @param key   [String] string value of a valid access key
      # @param fname [String] template for the file name
      # @return [String] The end point
      def self.h264_lo(id, key, fname = nil)
        HOST + "/asset/media/#{id}/#{key}/h264_mp4_lo_v1.0/" \
             + (fname || '%s-h264sm.mp4') % id
      end

      # Make ts media file end point
      # @param id    [String] asset identifier
      # @param key   [String] string value of a valid access key
      # @param fname [String] template for the file name
      # @return [String] The end point
      def self.ts(id, key, fname = nil)
        HOST + "/asset/media/#{id}/#{key}/ts/#{(fname || '%s.mpegts') % id}"
      end

      # Make stripped ts media file end point
      # @param id    [String] asset identifier
      # @param key   [String] string value of a valid access key
      # @param fname [String] template for the file name
      # @return [String] The end point
      def self.ts_stripped(id, key, fname = nil)
        HOST + "/asset/media/#{id}/#{key}/strip/" \
             + (fname || '%s-stripped.mpegts') % id
      end

    end

  end
end
