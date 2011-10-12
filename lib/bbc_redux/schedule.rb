module BBC
  module Redux
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

    end
  end
end