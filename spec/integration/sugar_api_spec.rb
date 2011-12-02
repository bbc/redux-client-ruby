require 'integration/integration_test_helpers'

describe BBC::Redux do

  include IntegrationTestHelpers

  it "should appear to work against the real API" do
    redux = BBC::Redux.login(username, password)

    # Check urls look OK
    [:mpeg2,:mpeg4,:mp3,:flv,:h264_lo,:h264_hi,:dvbsubs].each do |url_method|
      redux.send("#{url_method}_url", "5286433008768041518").should =~ /g.bbcredux.com/
    end

    # Content ok
    content = redux.content("5606393469443492993")
    content.title.should   == "British Olympic Dreams"

    # Key OK
    key = redux.key("5404438094219104161")
    key.value.should =~ /^#{redux.user.id}/

    # Schedule OK
    schedule = redux.tv_schedule(Time.gm(2010, 10, 10))
    schedule.size.should  == 191

    # Logout OK
    redux.logout

  end

end
