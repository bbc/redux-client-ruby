# Redux

A gem to help navigate the Redux API's and to screen scrape where an API does
not exist.

If you're reading this and you're not a BBC developer or authorised contractor
then it probably won't make much sense.

BBC Snippets and BBC Redux are tools designed to allow BBC staff to develop new
ways to view and navigate content. As such, they're not open to the public.

If you've been contracted by the BBC to do work in this area please feel free
to message us.

## Installation

### Bundler

    gem 'bbc_redux'

### RubyGems

    gem install bbc_redux

## Quick Start

    require 'bbc/redux'

    # Login

    client = BBC::Redux::Client.new({
      :username => 'username',
      :password => 'password',
    })

    # User data

    user = client.user
    
    user.can_invite?  #=> Boolean
    user.created      #=> DateTime
    user.email        #=> String
    user.first_name   #=> String
    user.id           #=> Integer
    user.last_name    #=> String
    user.username     #=> String
    user.uuid         #=> String

    # Available Channels

    client.channels   #=> Array<BBC::Redux::Channel>

    # Asset data

    asset = client.asset('5966413090093319525')
    
    asset.channel     #=> BBC::Redux::Channel
    asset.description #=> String
    asset.duration    #=> Integer
    asset.key         #=> BBC::Redux::Key
    asset.name        #=> String
    asset.reference   #=> String
    asset.start       #=> DateTime
    asset.uuid        #=> String

    # Media file urls ...

    # These are wrappers around an http url, each url is valid for 24 hours and
    # can be used without a session token

    asset.dvbsubs_url     #=> BBC::Redux::MediaUrl
    asset.flv_url         #=> BBC::Redux::MediaUrl
    asset.h264_hi_url     #=> BBC::Redux::MediaUrl
    asset.h264_lo_url     #=> BBC::Redux::MediaUrl
    asset.mp3_url         #=> BBC::Redux::MediaUrl
    asset.ts_url          #=> BBC::Redux::MediaUrl
    asset.ts_stripped_url #=> BBC::Redux::MediaUrl

    # URL helper methods

    url = asset.mp3_url
    
    url.expired?   #=> Boolean
    url.expires_at #=> DateTime
    url.live?      #=> Boolean
    url.ttl        #=> Integer
    url.end_point  #=> String

    # Generate an HTTP URL with a different filename
    
    url.end_point('myfile.mp3') #=> String
    
    # Download a file
    response  = redux.http.get(url.end_point)

    # Do something with response
    response.code     # 200 (you can but hope!)
    response.headers  # Hash
    response.body     # Your file or string

    # Get schedule
    client.schedule(Date.today).each do |asset|
      p asset.reference
    end

    # Get a schedule for specific channels
    schedule = client.schedule(Date.today, [ 'bbcone', 'bbctwo' ])

    # Search 

    results = client.search(:name => 'Pingu')
    
    results.created_at     #=> DateTime
    results.query          #=> Hash
    results.query_time     #=> Float
    results.assets         #=> Array<BBC::Redux::Asset>
    results.total          #=> Integer
    results.total_returned #=> Integer
    results.has_more?      #=> Boolean

    # Iterating all search results

    results = redux_client.search(:name => 'Pingu', :offset => 0)

    while true do
      results.assets.each do |asset|
        puts asset.name
      end

      if results.has_more?
        next_query = results.query.merge({
          :offset => results.query[:offset] + 10
        })

        results = redux_client.search(next_query)
      else
        break
      end
    end

    # Remembering to logout whe your done

    client.logout

## Documentation

Please see the ruby docs for full project documentation:

http://rubydoc.info/github/bbcsnippets/redux-client-ruby/version-4/frames

## Caveats / Known Issues

### Using a proxy server

The client uses [Typhoeus](https://github.com/dbalatero/typhoeus) which
respects the `http_proxy` environment variable

### "Your account has been comprimised"

You might get your account locked if you repeatedly login, especially from
multiple IP's. To be on the safe side you should reuse the `token` assigned to
a client.

Also, always remember to use `client.logout` when you are finished.

## Development

Please send new code in the form of a pull requests with tests. Run the current
test suite with ...

    rake coverage     # Generate code coverage report
    rake doc          # Gennerate docs
    rake integration  # Runs spec/integration/*_spec.rb - actually connects to redux
    rake spec         # Runs spec/**/*_spec.rb
