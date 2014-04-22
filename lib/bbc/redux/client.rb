require 'date'
require 'json'
require 'typhoeus'

module BBC
  module Redux

    class Client

      # Raised when backend HTTP API returns a 403, indicates you are either
      # trying to access some content that is unavailable to you, or your token
      # and session has expired.
      class ForbiddenException < Exception; end

      # Raised when backend HTTP API returns a 4XX or 5XX status other than
      # 403, indicates an error within the HTTP API or bug in this library
      class HttpException < Exception; end

      # Raised when backend HTTP API returns a body that does not parse as json
      class JsonParseException < Exception; end

      # @!attribute [r] http
      # @return [Object] http client, by default this is Typhoeus
      attr_reader :http

      # @!attribute [r] token
      # @return [String] token for current session
      attr_reader :token

      # @!attribute [r] host
      # @return [String] API HTTP host
      attr_reader :host

      # Client must be initialized with either a username and password
      # combination or a token
      #
      # @param [Hash] options the options to create client with
      # @option options [String] :username username of a redux account
      # @option options [String] :password password of a redux account
      # @option options [String] :token token for an existing redux session
      # @option options [String] :host (https://i.bbcredux.com) api host
      # @option options [Object] :http (Typhoeus) The http client, can be
      #   overidden but expects method .post to return an object looking like
      #   Typhoeus::Response (code, headers, body, etc)
      def initialize(options = {})
        @host  = options[:host] || 'https://i.bbcredux.com'
        @http  = options[:http] || Typhoeus
        @token = options[:token] || begin
          username = options[:username]
          password = options[:password]

          if username && password
            data = data_for(:login, {
              :username => username, :password => password
            })

            @token = data.fetch('token')
          else
            raise 'Supply either :token or :username and :password options'
          end
        end
      end

      # Fetch asset object
      # @param [String] identifier either disk reference or uuid
      # @see BBC::Redux::Asset
      # @return [BBC::Redux::Asset, nil] the asset
      def asset(identifier)
        if identifier =~ /^\d{19}$/
          params = { :reference => identifier }
        else
          params = { :uuid => identifier }
        end

        build :asset, :using => data_for(:asset, params)
      end

      # Fetch available channels for this session
      # @see BBC::Redux::Channel
      # @return [Array<BBC::Redux::Channel>] array of channels
      def channels
        build :channels, :using => data_for(:channels)
      end

      # Fetch available channel categories for this session
      # @see BBC::Redux::ChannelCategory
      # @return [Array<BBC::Redux::ChannelCategory>] array of channel categories
      def channel_categories
        build :channel_categories, :using => data_for(:channel_categories)
      end

      # Logout of redux, invalidates your token. After calling this you cannot
      # make any further requests with this client
      # @return [nil]
      def logout
        data_for(:logout)
        return nil
      end


      # Return all programmes for the schedule date, everything from 0600 for
      # 24 hours afterwards. May make multiple requests to backend to retreive
      # all the data
      #
      # @param [Date,DateTime,Time] date query this schedule date
      # @param [String,Array<String>,Channel,Array<Channel>,nil] channel
      #   optionally limit schedule query to one or an array of channels
      # @return [Array<BBC::Redux::Asset>] the list of assets broadcast on date
      def schedule(date, channels = nil)
        query   = {
          :date     => date,
          :channels => channels,
          :offset   => 0,
          :limit    => 100,
        }

        results = search(query)

        assets  = [ ]

        while true do

          assets.concat(results.assets)

          if results.has_more?
            next_query = results.query.merge({
              :offset => results.query[:offset] + 100
            })

            results = self.search(next_query)
          else
            break
          end
        end

        assets.sort { |a,b| a.start - b.start }
      end

      # Perform a search of Redux Archive
      #
      # @param [Hash] params your search parameters
      # @option params [String] :q free text query
      # @option params [String] :name query on programme name
      # @option params [String,Array<String>,Channel,Array<Channel>] :channel
      #   query on channel, e.g. 'bbcone'. Can provide an array to search on
      #   multiple channels.
      # @option params [Integer] :limit number of results to return. Default 10
      # @option params [Integer] :offset offset of the start of results
      # @option params [Date,DateTime,Time] :before only return braodcasts
      #   before date
      # @option params [Date,DateTime,Time] :after only return braodcasts after
      #   date
      # @option params [Date,DateTime,Time] :date everything from 0600 on given
      #   date for 24hrs
      # @option params [Integer] :longer constraint on the duration, in seconds
      # @option params [Integer] :shorter constraint on the duration, in seconds
      # @option params [String] :programme_crid TV Anytime CRID
      # @option params [String] :series_crid TV Anytime CRID
      # @see BBC::Redux::SearchResults
      # @return [BBC::Redux::SearchResults] search results
      def search(params = {})

        mapper = lambda do |val|
          if val.class == Date || val.class == DateTime || val.class == Time
            val.strftime('%Y-%m-%dT%H:%M:%S')
          elsif val.class == Channel
            val.name
          else
            val.to_s
          end
        end

        new_params = params.map do |key, val|
          if val.class == Array
            [ key, val.map(&mapper) ]
          else
            [ key, mapper.call(val) ]
          end
        end

        data = data_for(:search_results, Hash[new_params]).merge({
          'query' => params
        })

        build :search_results, :using => data
      end

      # Fetch user object for current session
      # @see BBC::Redux::User
      # @return [BBC::Redux::User, nil] the user
      def user
        build :user, :using => data_for(:user)
      end

      private

      # @private
      def build(type, options)
        data = options.fetch(:using)

        case type
        when :asset
          Serializers::Asset.new(Asset.new).from_hash(data)
        when :channels
          Serializers::Channels.new([]).from_hash(data)
        when :channel_categories
          Serializers::ChannelCategories.new([]).from_hash(data)
        when :search_results
          Serializers::SearchResults.new(SearchResults.new).from_hash(data)
        when :user
          Serializers::User.new(User.new).from_hash(data)
        end
      end

      # @private
      def url_for(action)
        case action
        when :asset
          host + '/asset/details'
        when :channels
          host + '/asset/channel/available'
        when :channel_categories
          host + '/asset/channel/categories'
        when :login
          host + '/user/login'
        when :logout
          host + '/user/logout'
        when :search_results
          host + '/asset/search'
        when :user
          host + '/user/details'
        end
      end

      # @private
      def data_for(action, params = {})
        url  = url_for action

        # Patch typhoeus / ethon's handling of array params, essentially
        # turn this /?key[0]=1&key[1]=2&key[2]=3 into this
        # /?key=1&key=2&key=3

        arrays = params.select { |_,v| v.class == Array }

        unless arrays.empty?
          url += '?' unless url =~ /\?$/

          arrays.each do |key, values|
            url += values.map { |v| "#{key}=#{v}" }.join('&')
          end
        end

        params = params.select { |_,v| v.class != Array }

        resp = http.post(url, {
          :body           => params.merge(:token => token),
          :followlocation => true,
        })

        case resp.code
        when 200
          JSON.parse(resp.body)
        when 403
          raise ForbiddenException.new("403 response for #{url}")
        when 400..599
          raise HttpException.new("#{resp.code} response for #{url}")
        else
          raise "Umm, not sure how to handle #{resp.code} for #{url}"
        end

      rescue JSON::ParserError => e
        raise JsonParseException.new("Error parsing #{url}, #{e.message}")
      end

    end

  end
end
