require 'virtus'
require_relative 'asset'

module BBC
  module Redux

    # Search results container
    #
    # @example Properties of search results
    #
    #   results = redux_client.search(:name => 'Pingu')
    #
    #   results.created_at     #=> DateTime
    #   results.query          #=> Hash
    #   results.query_time     #=> Float
    #   results.assets         #=> Array<BBC::Redux::Asset>
    #   results.total          #=> Integer
    #   results.total_returned #=> Integer
    #   results.has_more?      #=> Boolean
    #   results.next_query     #=> Hash
    #
    # @example Iterating search results
    #
    #   results = redux_client.search(:name => 'Pingu')
    #
    #   while true do
    #     results.each do |asset|
    #       puts asset.name
    #     end
    #
    #     if results.has_more?
    #       results = redux_client.search(results.next_query)
    #     else
    #       break
    #     end
    #   end
    #
    class SearchResults

      include Virtus.value_object

      # @!attribute [r] created_at
      # @return [DateTime] date and time results were retrieved
      attribute :created_at, DateTime

      # @!attribute [r] query
      # @return [Hash] original parameters used in this query
      attribute :query, Hash

      # @attribute [r] query_time
      # @return [Float] query time in seconds
      attribute :query_time, Float

      # @!attribute [r] assets
      # @return [Array<BBC::Redux::Asset>] assets returned in this query
      attribute :assets, Array[Asset]

      # @!attribute [r] offset
      # @return [Integer] offset of this set of results
      attribute :offset, Integer

      # @!attribute [r] total
      # @return [Integer] total number of results
      attribute :total, Integer

      # @!attribute [r] total_returned
      # @return [Integer] total number of results returned in this query
      attribute :total_returned, Integer

      # @see SearchResults#next_query
      # @return [Boolean] true if there are more results available than
      #   returned in this query
      def has_more?
        (offset + total_returned) < total
      end

      # @see SearchResults#has_more?
      # @return [Hash,nil] a hash containing the query parameters for the next
      #   set of results if SearchResults#has_more? is true. Nil otherwise
      def next_query
        if has_more?
          query  = self.query || { }
          limit  = query[:limit] || 10
          offset = (query[:offset] || 0) + limit
          query.merge :limit => limit, :offset => offset
        end
      end

    end

  end
end
