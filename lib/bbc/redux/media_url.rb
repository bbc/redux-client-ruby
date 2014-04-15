require 'forwardable'
require_relative 'end_points'
require_relative 'key'

module BBC
  module Redux

    # Redux API Asset URL Object
    #
    # Each asset is available as various transcodes using the url function.
    # The urls are key based and therefore generally have a lifetime of 24 hours    #
    #
    # @example Properties of the url object
    #
    #   url = redux_client.asset('5966413090093319525').url(:mp3)
    #
    #   url.expired?   #=> Boolean
    #   url.expires_at #=> DateTime
    #   url.live?      #=> Boolean
    #   url.ttl        #=> Integer
    #   url.end_point  #=> String
    #
    # @example generate a URL with a different filename
    #
    #   url = redux_client.asset('5966413090093319525').url(:mp3)
    #
    #   url.end_point('myfile.mp3') #=> String
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class MediaUrl

      # Error raised when trying to initiate url with an unknown template type
      class UnknownTemplateType < Exception; end

      # Known URL templates, these are the only valid options for the
      # type attribute of MediaUrl.initialize.
      # @see MediaUrl#initialize
      TEMPLATES = [
        :dvbsubs,
        :flv,
        :h264_hi,
        :h264_lo,
        :mp3,
        :ts,
        :ts_stripped
      ].freeze

      # @!attribute [r] expires_at
      # @return [DateTime] the access url's expiry time

      # @!method expired?
      # @see MediaUrl#expired?
      # @see MediaUrl#ttl
      # @return [Boolean] true if ttl <= 0, false otherwise

      # @!method live?
      # @see MediaUrl#expired?
      # @see MediaUrl#ttl
      # @return [Boolean] true if ttl > 0, false otherwise

      # @!method ttl
      # @see MediaUrl#expired?
      # @see MediaUrl#live?
      # @return [Integer] url's time to live in seconds

      # @private
      extend Forwardable

      def_delegators :@key, :expired?, :expires_at, :live?, :ttl

      # @!attribute [r] identifier
      # @return [String] the url's indentifier
      attr_reader :identifier

      # @!attribute [r] type
      # @see MediaUrl.TYPES
      # @return [Symbol] the url's type
      attr_reader :type

      # @!attribute [r] key
      # @return [BBC::Redux::Key] the url's key
      attr_reader :key

      # @param identifier [String] the disk reference or UUID of the asset
      # @param type [Symbol] the transcode type, must be one of MediaUrl.TYPES
      # @param key [BBC::Redux:Key] the key
      # @raise [UnknownTranscodeType] if type parameter is unknown
      # @see MediaUrl.TYPES
      def initialize( identifier, type, key )

        unless TEMPLATES.include?(type)
          raise UnknownTemplateType.new("Unknown template type #{type}")
        end

        @identifier = identifier
        @type       = type
        @key        = key
      end

      # Generate the end point to retreive media file
      #
      # @param filename [String] an optional filename to specify on the end
      #   point. This can also contain a "%s" template that will be populated
      #   with the MediaUrl#identifier
      # @return [String] The URL end point
      def end_point(filename = nil)
        EndPoints.send(type, identifier, key.value, filename)
      end

      alias :to_s :end_point

      # @return [Boolean] true if other_url is a redux url with the same type,
      #   identifier and key
      def ==(other_url)
        self.class == other_url.class && self.end_point == other_url.end_point
      end

      alias :eql? :==

    end

  end
end
