require 'virtus'

module BBC
  module Redux

    # Redux API Channel Object
    #
    # @example Properties of the channel object
    #
    #   channel = redux_client.channels.first
    #
    #   channel.category_id  #=> Integer
    #   channel.display_name #=> String
    #   channel.name         #=> String
    #   channel.sort_order   #=> Integer
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class Channel

      include Virtus.value_object

      # @!attribute [r] category_id
      # @return [Integer] channel's category id
      attribute :category_id, Integer

      # @!attribute [r] display_name
      # @return [String] channel display name, e.g. 'BBC One'
      attribute :display_name, String

      alias :longname :display_name

      # @!attribute [r] name
      # @return [String] channel short name, e.g. 'bbcone'
      attribute :name, String

      # @!attribute [r] sortorder
      # @return [Integer] channel's suggested sort order in list views
      attribute :sortorder, Integer

      alias :sort_order :sortorder

    end

  end
end
