require 'virtus'
require_relative 'channel'
require_relative 'key'
require_relative 'media_url'

module BBC
  module Redux

    # Redux Crid Object
    #
    # @example Properties of the crid object
    #
    #   crid = redux_client.asset('5966413090093319525').pcrid
    #
    #   crid.content      #=> String
    #   crid.description  #=> String
    #   crid.type         #=> String
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class Crid

      include Virtus.value_object

      # @!attribute [r] content
      # @return [String] the crids content, e.g. crid://fp.bbc.co.uk/LYRJ9T
      attribute :content, String

      alias :to_s :content

      # @!attribute [r] description
      # @return [String] the crid's description, e.g. "DTG series CRID"
      attribute :description, String

      # @!attribute [r] type
      # @return [String] the crid's type byte value, e.g. "0x32"
      attribute :type, String

    end

  end
end
