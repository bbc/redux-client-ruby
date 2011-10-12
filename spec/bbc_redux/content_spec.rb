require "spec_helper"

describe BBC::Redux::Content do

  describe ".from_xml" do
    it "should build an object from an XML response" do
      xml = %Q{<?xml version="1.0" encoding="UTF-8" ?>
      <response>
        <programme frames="1">
          <time>18:55:00</time>
          <date>2010-12-25</date>
          <channel>bbctwo</channel>
          <reference>5554695377586026009</reference>
          <duration>3600</duration>
          <unixtime>1293303300</unixtime>
          <description>Some description</description>
          <series_crid>fp.bbc.co.uk/KRYRHR</series_crid>
          <programme_crid>fp.bbc.co.uk/1RE93D</programme_crid>
          <name>Top Gear</name>
          <media type="flash" uri="blah" size="232572028" generated="1"/>
          <key>some-key's-value</key>
        </programme>
      </response>
      }
      xml_content = BBC::Redux::Content.from_xml(xml)
      xml_content.disk_reference.should       == "5554695377586026009"
      xml_content.duration.should             == 3600
      xml_content.start_date.should           == Time.at(1293303300)
      xml_content.channel.should              == "bbctwo"
      xml_content.title.should                == "Top Gear"
      xml_content.description.should          == "Some description"
      xml_content.series_crid.should          == "fp.bbc.co.uk/KRYRHR"
      xml_content.programme_crid.should       == "fp.bbc.co.uk/1RE93D"
      xml_content.key.value.should            == "some-key's-value"
      xml_content.generated_frames?.should    == true
      xml_content.generated_flv?.should       == true
    end
  end

  def data
    @data ||= {
      :disk_reference => "some-disk-reference",
      :duration       => 3600,
      :start_date     => Time.now,
      :channel        => "some-channel",
      :frames         => true,
      :flv            => true,
      :title          => "some-title",
      :description    => "some-description",
      :series_crid    => "some-series_crid",
      :programme_crid => "some-programme-crid",
      :key            => BBC::Redux::Key.new("some-value")
    }
  end

  def content
    BBC::Redux::Content.new data
  end

  [:disk_reference, :duration, :start_date, :channel, :title, :description, :series_crid, :programme_crid, :key].each do |attribute|
    it "should expose #{attribute}" do
      content.send(attribute).should == data[attribute]
    end
  end

  it 'should expose whether frames have been generated via generated_frames?' do
    content.generated_frames?.should == true
  end

  it 'should expose whether frames have been generated via generated_flv?' do
    content.generated_flv?.should == true
  end

end