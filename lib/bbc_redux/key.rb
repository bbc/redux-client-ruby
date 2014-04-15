module BBC
  class Redux
    class Key

      def self.from_xml(xml_string)
        xml = Nokogiri::XML(xml_string)
        val = xml.xpath("/response/programme/key").first.text
        self.new(val)
      end

      attr_reader :value, :created_at

      def initialize(value)
        @value      = value
        @created_at = Time.now
      end

      def expires_at
        created_at + (60 * 60 * 24)
      end

      def expired?
        expires_at <= Time.now
      end

      def valid?
        !expired?
      end

    end
  end
end
