require 'virtus'
require_relative 'channel'
require_relative 'crid'
require_relative 'key'
require_relative 'media_url'

module BBC
  module Redux

    # Redux API Asset Object
    #
    # @example Properties of the asset object
    #
    #   asset = redux_client.asset('5966413090093319525')
    #
    #   asset.channel     #=> BBC::Redux::Channel
    #   asset.description #=> String
    #   asset.duration    #=> Integer
    #   asset.key         #=> BBC::Redux::Key
    #   asset.name        #=> String
    #   asset.pcrid       #=> BBC::Redux::Crid
    #   asset.reference   #=> String
    #   asset.scrid       #=> BBC::Redux::Crid
    #   asset.start       #=> DateTime
    #   asset.uuid        #=> String
    #
    # @example Generating urls for the asset's associated media files
    #
    #   asset.dvbsubs_url     #=> BBC::Redux::MediaUrl
    #   asset.flv_url         #=> BBC::Redux::MediaUrl
    #   asset.h264_hi_url     #=> BBC::Redux::MediaUrl
    #   asset.h264_lo_url     #=> BBC::Redux::MediaUrl
    #   asset.mp3_url         #=> BBC::Redux::MediaUrl
    #   asset.ts_url          #=> BBC::Redux::MediaUrl
    #   asset.ts_stripped_url #=> BBC::Redux::MediaUrl
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class Asset

      include Virtus.value_object

      # @!attribute [r] channel
      # @return [Channel] the asset's channel
      attribute :channel, BBC::Redux::Channel

      # @!attribute [r] description
      # @return [String] the asset's description
      attribute :description, String

      # @!attribute [r] duration
      # @return [Integer] the asset's duration in seconds
      attribute :duration, Integer

      # @private
      # @!attribute [r] access_key
      # @return [String] the asset's access key
      attribute :access_key, String

      # @!attribute [r] start
      # @return [DateTime] the asset's start date / time. Generally schedule
      # time
      attribute :start,  DateTime

      # @!attribute [r] reference
      # @return [String] the asset's disk reference
      attribute :reference, String

      alias :disk_reference :reference

      # @!attribute [r] name
      # @return [String] the asset's name / title
      attribute :name, String

      alias :title :name

      # @!attribute [r] uuid
      # @return [String] the assets's uuid
      attribute :uuid, String

      # @!attribute [r] crids
      # @return [String] the assets's crids
      attribute :crids, Array[BBC::Redux::Crid], :default => [ ]

      # @!attribute [r] key
      # @return [Key] the asset's access key object
      def key
        @key ||= Key.new(access_key)
      end

      # @!attribute [r] pcrid
      # @return [Key] the asset's programme crid
      def pcrid
        @pcrid ||= crids.find { |c| c.description =~ /programme/ }
      end

      # @!attribute [r] scrid
      # @return [Key] the asset's series crid
      def scrid
        @scrid ||= crids.find { |c| c.description =~ /series/ }
      end

      private

      def self.has_media_url(type)
        define_method(:"#{type}_url") do
          MediaUrl.new(reference, type, key)
        end
      end

      public

      # @!macro [new] has_media_url
      #   @!attribute [r] $1_url
      #     @return [BBC::Redux::MediaUrl] a media url for the $1 file
      has_media_url :dvbsubs

      # @macro has_media_url
      has_media_url :flv

      # @macro has_media_url
      has_media_url :h264_hi

      # @macro has_media_url
      has_media_url :h264_lo

      # @macro has_media_url
      has_media_url :mp3

      # @macro has_media_url
      has_media_url :ts

      # @macro has_media_url
      has_media_url :ts_stripped

    end

  end
end
