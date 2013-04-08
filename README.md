# Redux

A gem to help navigate the Redux API's and to screen scrape where an API does not exist.

If you're reading this and you're not a BBC developer or authorised contractor then it probably won't make much sense.

BBC Snippets and BBC Redux are tools designed to allow BBC staff to develop new ways to view and navigate content. As such, they're not open to the public.

If you've been contracted by the BBC to do work in this area please feel free to message us.

## Installation

Use [Bundler](http://gembundler.com/) + git, add this to your `Gemfile`

    gem "bbc_redux", :git => "git://github.com/bbcsnippets/redux-client-ruby.git"

In your code

    require "bbc_redux"

## Quick Start

We have written a "sugar" layer on top of the core API, use this if you ...

* don't really care about how redux works
* want to write less code
* want to be able to mock out calls easily

Whether you use the quick abstraction layer or the underlying API make sure you read the section "Caveats / Known Issues" below.

    # Login
    redux = BBC::Redux.login("username", "password")

    # User details
    redux.user.id           # Int
    redux.user.username     # String
    redux.user.first_name   # String
    redux.user.last_name    # String
    redux.user.email        # String

    # Content data
    data  = redux.content("5286433008768041518")
    data.title             # String
    data.description       # String
    data.disk_reference    # String
    data.duration          # Int (seconds)
    data.start_date        # Date
    data.channel           # String (e.g. "bbctwo")
    data.series_crid       # String
    data.programme_crid    # String
    data.generated_frames? # Boolean
    data.generated_flv?    # Boolean

    # Media file urls ...
    redux.mpeg2_url("5286433008768041518")    # String
    redux.mpeg4_url("5286433008768041518")    # String
    redux.mp3_url("5286433008768041518")      # String
    redux.flv_url("5286433008768041518")      # String
    redux.h264_lo_url("5286433008768041518")  # String
    redux.h264_hi_url("5286433008768041518")  # String
    redux.dvbsubs("5286433008768041518")      # String

    # You can optionally specify a filename for the media, this will affect the Content-Disposition
    # header of the http response
    redux.mpeg2_url("5286433008768041518", "my-mpeg2-file")    # String

    # Download a file
    # NB: Generated media file urls contain a cryptographic hash so
    # do not require a valid session cookie. Therefore you could
    # use your own HTTP connection for this
    url       = redux.mpeg2_url("5286433008768041518")
    response  = redux.client.get(url)

    # Do something with response
    response.code     # 200 (you can but hope!)
    response.headers  # Hash
    response.body     # Your file or string

    # Get a TV schedule
    redux.tv_schedule(date).each do |disk_reference|
      content = redux.content(disk_reference)
    end

    # Remembering to logout whe your done
    redux.logout


## Core API Usage

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
    data.title             # String
    data.description       # String
    data.disk_reference    # String
    data.duration          # Int (seconds)
    data.start_date        # Date
    data.channel           # String (e.g. "bbctwo")
    data.series_crid       # String
    data.programme_crid    # String
    data.generated_frames? # Boolean
    data.generated_flv?    # Boolean
    data.key               # Key

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

You can download files from redux, available urls are mpeg2, mpeg4, mp3, flv, h264\_lo, h264\_hi, dvbsubs. You can use the `Url.*` functions to build a URL and use within your own code, or you can use it with `client.get` which will return a `Typhoeus` response object.

    key       = client.key("5286433008768041518", user.session)
    url       = BBC::Redux::Url.flv("5286433008768041518", key)
    response  = client.get(url)

    # Do something with response
    response.code     # 200 (you can but hope!)
    response.headers  # Hash
    response.body     # Your file or string

### Getting a schedule

Currently you can only retrieve a TV Schedule and to do that we rely on screen scraping Redux. Also it's not so much a schedule, rather an array of disk references broadcast on a particular date.

    schedule = client.tv_schedule(date, user.session)
    schedule.each do |disk_reference|
      content = client.content(disk_reference, user.session)
    end

May throw any one of the following errors ...

    BBC::Redux::Exceptions::SessionInvalidException  # Your session has expired / become invalid
    BBC::Redux::Exceptions::ClientHttpException      # Some other HTTP error


### Keeping Session alive

Reason for implementing this feature was to ensure that users who left their browsers open but didn't interact with Snippets will not be logged out, unless they
explicitly shut their browsers down. One can use the following code for polling Redux to keep the session alive.

    client.ping(user.session)

May throw the following errors ...

    BBC::Redux::Exceptions::ClientHttpException      # Some other HTTP error


## Caveats / Known Issues

### Using a proxy server

The client uses [Typhoeus](https://github.com/dbalatero/typhoeus) which respects the `http_proxy` environment variable

### Password is sent to Redux unencrypted

Redux has no HTTPS, also for some reason the API call for logging in is a GET request.

### "Your account has been comprimised"

You might get your account locked if you repeatedly login, especially from multiple IP's. To be on the safe side you should reuse the `user` and `user.session` object throughout you application (though beware it may time out with several hours inactivity).

Also, always remember to use `client.logout(user.session)` when you are finished.

### No radio schedule / disk reference lists

The schedule list relies on screen scraping Redux, unfortunately we can't get the disk references for radio in a single request (it's n+1 requests, where n = number of radio shows in a day! See Redux radio schedule pages HTML for the problem).

## Development

Please send new code in the form of a pull requests with tests. Run the current test suite with ...

    rake spec         # Runs spec/**/*_spec.rb
    rake integration  # Runs spec/integration/*_spec.rb - actually connects to redux
    rake coverage     # Generate code coverage report
