require 'virtus'

module BBC
  module Redux

    # Redux API Channel Category Object
    #
    # @example Properties of the channel category object
    #
    #   category = redux_client.channel_categories.first
    #
    #   category.description  #=> String
    #   category.id           #=> Integer
    #   category.priority     #=> Integer
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class ChannelCategory

      include Virtus.value_object

      # @!attribute [r] description
      # @return [String] category's description, e.g. 'BBC TV'
      attribute :description, String

      # @!attribute [r] id
      # @return [Integer] category's id
      attribute :id, Integer

      # @!attribute [r] priority
      # @return [String] category's priority, a hint for display in views
      attribute :priority, Integer

    end

  end
end
