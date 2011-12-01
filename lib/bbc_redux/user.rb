module BBC
  class Redux
    class User

      def self.from_xml(xml_string)

        xml = Nokogiri::XML(xml_string)

        self.new({
          :id         => xml.xpath("/response/user/id").first.text.to_i,
          :username   => xml.xpath("/response/user/username").first.text,
          :first_name => xml.xpath("/response/user/first_name").first.text,
          :last_name  => xml.xpath("/response/user/last_name").first.text,
          :email      => xml.xpath("/response/user/email").first.text,
          :session    => Session.new(xml.xpath("/response/user/token").first.text)
        })

      end

      attr_reader :id, :username, :first_name, :last_name, :email, :session

      def initialize(attributes)
        attributes.each_pair do |key, val|
          self.instance_variable_set(:"@#{key}", val)
        end
      end

    end
  end
end