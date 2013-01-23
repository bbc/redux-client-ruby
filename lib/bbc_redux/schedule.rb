require 'nokogiri'

module BBC
  class Redux
    module Schedule

      def self.from_tv_html(html_string)
        xml = Nokogiri::HTML(html_string)
        xml.xpath("//img").map do |element|
          if element.xpath("@src").first.text =~ /\/programme\/(\d+)/
            $1
          else
            nil
          end
        end.compact
      end

      def self.from_radio_html(html_string)
        # The Schedule module is just a parser and doesn't have HTTP methods,
        # it's better to pass hrefs back to the client to make the follow-up
        # requests. So, we need a block passed in to do that.
        raise "Block required to process radio programme URLs" unless block_given?
        xml = Nokogiri::HTML(html_string)
        xml.xpath("//a[#{xpath_class("proghead")}]/@href").map do |href|
          yield href.value
        end
      end

      def self.from_radio_programme_html(html_string)
        # We're totally at the mercy of the markup of the programme page,
        # expect to need to change this regexp at some point
        if match = html_string.match(%r{Disk ref(?:erence)?\s*:\s*([0-9/]+)}i)
          match[1].split("/").last
        end
      end

      private
      def self.xpath_class klass
        ".//div[contains(concat(' ', @class, ' '), ' #{klass} ')]"
      end

    end
  end
end
