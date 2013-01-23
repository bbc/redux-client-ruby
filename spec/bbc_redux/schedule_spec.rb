require "spec_helper"

describe BBC::Redux::Schedule do

  describe ".from_tv_html" do
    it "should work" do
      schedule = BBC::Redux::Schedule.from_tv_html(tv_html_string)
      schedule.size.should  == 201
      schedule.first.should == "5564143876136277914"
    end
  end

  describe ".from_radio_html" do
    it "should work" do
      schedule = BBC::Redux::Schedule.from_radio_html(radio_html_string) { |href| href }
      schedule.size.should  == 176
      # Value returned from first iteration of above block
      schedule.first.should == "/programme/bbcr1/2011-01-20/06-30-00"
    end
  end

  describe ".from_radio_programme_html" do
    it "should work" do
      BBC::Redux::Schedule.from_radio_programme_html(radio_programme_html_string).should == "5564151608016670253"
    end
  end

  def tv_html_string
    File.read("spec/fixtures/tv_schedule.html")
  end

  def radio_html_string
    File.read("spec/fixtures/radio_schedule.html")
  end

  def radio_programme_html_string
    File.read("spec/fixtures/radio_programme.html")
  end

end

