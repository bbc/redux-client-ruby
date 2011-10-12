module BBC
  module Redux
    class Content

      def self.from_xml(xml_string)

        xml = Nokogiri::XML(xml_string)

        self.new({
          :disk_reference => xml.xpath("/response/programme/reference").first.text,
          :duration       => xml.xpath("/response/programme/duration").first.text.to_i,
          :start_date     => Time.at(xml.xpath("/response/programme/unixtime").first.text.to_i),
          :channel        => xml.xpath("/response/programme/channel").first.text,
          :frames         => xml.xpath("/response/programme/@frames").first.value == "1",
          :flv            => xml.xpath("/response/programme/media[@type='flash']/@generated").size > 0,
          :title          => xml.xpath("/response/programme/name").first.text,
          :description    => xml.xpath("/response/programme/description").first.text,
          :series_crid    => xml.xpath("/response/programme/series_crid").first.text,
          :programme_crid => xml.xpath("/response/programme/programme_crid").first.text,
          :key            => Key.new(xml.xpath("/response/programme/key").first.text)
        })

      end

      attr_reader :disk_reference, :duration, :start_date, :channel,
                  :title, :description, :series_crid, :programme_crid, :key

      def initialize(attributes)
        attributes.each_pair do |key, val|
          self.instance_variable_set(:"@#{key}", val)
        end
      end

      def generated_frames?
        @frames
      end

      def generated_flv?
        @flv
      end

    end
  end
end