# Redux

A gem to help navigate the Redux API's and to screen scrape where an API does not exist.

## Installation

Use [Bundler](http://gembundler.com/) + git, add this to your `Gemfile`

    gem "bbc_redux", :git => "http://github.com/bbcsnippets/redux-client-ruby"

In your code

    require "bbc_redux"

## Usage

### Users and sessions

You need to use the client to login into Redux, this will return you a `User` object with an associated `Session` that you need to use to make further requests ...

    client = BBC::Redux::Client.new
    user   = client.login("username", "password")

    user.id           # Int
    user.username     # String
    user.first_name   # String
    user.last_name    # String
    user.email        # String
    user.session      # Session

    # Remembering to logout whe your done
    client.logout(user.session)

May throw any one of the following errors ...

    BBC::Redux::Exceptions::UserNotFoundException # Bad username
    BBC::Redux::Exceptions::UserPasswordException # Bad password
    BBC::Redux::Exceptions::ClientHttpException   # Some other HTTP error

### Getting some data

You can retrieve data from Redux ...

    data  = client.content("5286433008768041518", user.session)
    data.title            # String
    data.description      # String
    data.disk_reference   # String
    data.duration         # Int (seconds)
    data.start_date       # Date
    data.channel          # String (e.g. "bbctwo")
    data.frames           # Boolean
    data.series_crid      # String
    data.programme_crid   # String
    data.key              # Key

May throw any one of the following errors ...

    BBC::Redux::Exceptions::ContentNotFoundException # Bad disk reference (or for some reason Redux cannot find it)
    BBC::Redux::Exceptions::SessionInvalidException  # Your session has expired / become invalid
    BBC::Redux::Exceptions::ClientHttpException      # Some other HTTP error

### Keys

Keys are required to access any media files on Redux, a key is returned each time you call `client.content`, but a slightly faster API call is available ...

    key = client.key("5286433008768041518", user.session)

May throw any one of the following errors ...

    BBC::Redux::Exceptions::ContentNotFoundException # Bad disk reference (or for some reason Redux cannot find it)
    BBC::Redux::Exceptions::SessionInvalidException  # Your session has expired / become invalid
    BBC::Redux::Exceptions::ClientHttpException      # Some other HTTP error

A key should be valid for ~24 hours, there are some helper methods around this

    key.created_at  # Date
    key.expires_at  # Date
    key.valid?      # Boolean
    key.expired?    # Boolean

### Getting some files

You can download files from redux, available urls are mpeg2, mpeg4, mp3, flv, h264\_lo, h264\_hi, dvbsubs. You can use the `Url.*` functions to build a URL and within your own code, or you can user `client.get` which will return a `Typhoeus` response object.

    key       = client.key("5286433008768041518", user.session)
    url       = BBC::Redux::Url.flv("5286433008768041518", key)
    response  = client.get(url)

    # Do something with response
    response.code     # 200 (you can but hope!)
    response.headers  # Hash
    response.body     # Your file

### Getting a schedule

TODO

## Caveats / Known Issues

### Using a proxy server

The client uses [Typhoeus](https://github.com/dbalatero/typhoeus) which respects the `http_proxy` environment variable

### Password is sent to Redux unencrypted

Redux has no HTTPS, also for some reason the API call for logging in is a GET request.

### "Your account has been comprimised"

You might get you account locked if repeatedly login, especially from multiple IP's. To be on the safe side you should reuse the `user` and `user.session` object throughout you application (though beware it may time out with several hours inactivity).

Also, always remember to use `client.logout(user.session)` when you are finished.

### No radio schedule / disk reference lists

The schedule list relies on screen scraping Redux, unfortunately we can't get the disk references for radio in a single request (it's n+1 requests, where n = number of radio shows in a day! See Redux radio schedule pages HTML for the problem).

## Development

Please send new code in the form of a pull requests with tests. Run the current test suite with ...

    rake spec         # Runs spec/*_spec.rb
    rake integration  # Runs spec/integration_test.rb - actually connects to redux

