module BBC
  module Redux

    # Redux API Asset Key Object
    #
    # Each asset is served with an associated key that is needed to access
    # it's associated media. Generally these keys have a lifetime of 24 hours
    #
    # @example Properties of the key object
    #
    #   key = redux_client.asset('5966413090093319525').key
    #
    #   key.expired?   #=> Boolean
    #   key.expires_at #=> DateTime
    #   key.live?      #=> Boolean
    #   key.ttl        #=> Integer
    #   key.value      #=> String
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class Key

      # @!attribute [r] expires_at
      # @return [DateTime] the access key's expiry time
      attr_reader :expires_at

      # @!attribute [r] value
      # @return [String] the access key's value
      attr_reader :value

      # @param value [String] the access keys value
      def initialize(value)
        @value      = value
        @expires_at = Time.at( value.split('-')[1].to_i ).to_datetime
      end

      # @see Key#expired?
      # @see Key#ttl
      # @return [Boolean] true if ttl <= 0, false otherwise
      def expired?
        ttl <= 0
      end

      # @see Key#expired?
      # @see Key#ttl
      # @return [Boolean] true if ttl > 0, false otherwise
      def live?
        ttl > 0
      end

      # @return the key's value as a string
      def to_s
        value
      end

      # @see Key#expired?
      # @see Key#expires_at
      # @see Key#live?
      # @return [Integer] key's Time To Live in seconds
      def ttl
        expires_at.to_time.to_i - Time.now.to_i
      end

      # @return [Boolean] true if other_key is a redux key with the same value
      def ==(other_key)
        self.class == other_key.class && self.value == other_key.value
      end

      alias :eql? :==

    end

  end
end
