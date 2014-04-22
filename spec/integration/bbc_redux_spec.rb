require 'spec_helper'

describe BBC::Redux do

  let(:username) { @username ||= ask('Please enter redux user: ')       }
  let(:password) { @password ||= ask('Please enter redux pass: ', true) }

  it 'should work' do

    client = BBC::Redux::Client.new({
      :username => username, :password => password,
    })

    # Test Asset
    asset = client.asset('5966413090093319525')

    expect(asset.channel.class).to eq(BBC::Redux::Channel)
    expect(asset.channel.display_name).to eq('CBeebies')
    expect(asset.channel.name).to eq('cbeebies')

    expect(asset.description).to eq('Pingu\'s Moon Adventure: Animated ' +
      'adventures of Pingu, the clumsy young penguin. Pingu wants to visit' +
      ' the moon so he makes a rocket out of an old barrel, tin foil and' +
      ' snow. [S]')

    expect(asset.disk_reference).to eq('5966413090093319525')
    expect(asset.duration).to eq(300)
    expect(asset.key.class).to eq(BBC::Redux::Key)
    expect(asset.name).to eq('Pingu')
    expect(asset.start).to eq(DateTime.parse('2014-01-08 06:50:00 +0000'))
    expect(asset.uuid).to eq('26a141fc-8511-4fef-aa2b-af1d1de5a75a')

    # Test media url
    resp = client.http.head(asset.flv_url)
    expect(resp.code).to eq(200)

    # Test channels
    channels = client.channels

    expect(channels.first.class).to eq(BBC::Redux::Channel)

    # Test search
    results = client.search(:limit => 100, :channel => [ 'bbcone', 'bbctwo' ])

    ones = results.assets.select {|a| a.channel.name == 'bbcone' }
    twos = results.assets.select {|a| a.channel.name == 'bbctwo' }

    # Channel array query thing works
    expect(ones.size > 0).to eq(true)
    expect(twos.size > 0).to eq(true)
    expect(ones.size + twos.size).to eq(results.assets.size)

    # Test channel_categories
    categories = client.channel_categories

    expect(categories.first.class).to eq(BBC::Redux::ChannelCategory)

    # Test user
    user = client.user

    expect(user.username).to eq(username)
    expect(user.class).to eq(BBC::Redux::User)

    # Test logout
    expect(client.logout).to be(nil)
  end

  private

  def ask(question, quietly = false)
    print question
    system 'stty -echo' if quietly
    answer = $stdin.gets.chomp
    system 'stty echo' if quietly
    return answer
  end

end
