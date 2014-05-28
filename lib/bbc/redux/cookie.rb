module BBC
  module Redux

    # Redux Cookie util class
    #
    # A utility class for creating and parsing correct Redux cookies. Can be
    # constructed from an existing client object or a raw cookie string
    #
    # @example Build cookie from client
    #
    #   client = BBC::Redux::Client.new({
    #     :username => 'username',
    #     :password => 'password',
    #   })
    #
    #   cookie = BBC::Redux::Cookie.new(client)
    #
    #   cookie.token  #=> String
    #   cookie.client #=> BBC::Redux::Client
    #   cookie.to_s   #=> String
    #
    # @example Build cookie from existing value
    #
    #   string = "BBC_video=some-token; domain=.bbcredux.com; path=/"
    #
    #   cookie = BBC::Redux::Cookie.new(string)
    #
    #   cookie.token  #=> String
    #   cookie.client #=> BBC::Redux::Client
    #   cookie.to_s   #=> String
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class Cookie

      # @!attribute [r] token
      # @return [String] session token
      attr_reader :token

      # @!attribute [r] string
      # @return [String] string representation of cookie, for use in HTTP
      #   responses Set-Cookie header
      attr_reader :string

      alias :to_s :string

      # @!attribute [r] client
      # @return [BBC::Redux::Client] client object built from token
      attr_reader :client

      # Build cookie from eith a client object or string value (the literal
      # value of a prior HTTP cookie)
      #
      # @param [String|BBC::Redux::Client] value value to build cookie from
      # @raise [ArgumentError] cookie string format incorrect, or non client
      #   object given
      def initialize(value)
        if value.class == BBC::Redux::Client
          @token  = value.token
          @client = value
          @string = build_string(token)
        elsif value.class == String
          if value =~ /BBC_video=(.*);\s+domain=.bbcredux.com;\s+path=\//
            @token  = $1
            @client = BBC::Redux::Client.new( :token => token )
            @string = build_string(token)
          else
            raise ArgumentError.new('bad cookie format')
          end
        else
          raise ArgumentError.new('provide BBC::Redux::Client or String')
        end
      end

      # @return [Boolean] true if other_cookie is a redux cookie with the same
      #   token
      def ==(other_cookie)
        self.class == other_cookie.class && self.token == other_cookie.token
      end

      alias :eql? :==

      private

      def build_string(token)
        "BBC_video=#{token}; domain=.bbcredux.com; path=/"
      end

    end

  end
end
