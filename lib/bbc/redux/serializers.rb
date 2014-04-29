require 'representable'
require 'representable/json'
require 'representable/json/collection'

require_relative 'channel'

module BBC
  module Redux

    # @private
    module Serializers

      class Asset < Representable::Decorator
        include Representable::JSON

        property :description
        property :access_key, :as => :key
        property :name
        property :reference
        property :uuid

        nested :timing do
          property :duration
          property :start
        end

        property :channel, :class => BBC::Redux::Channel do
          property :name
          property :display_name
        end

        collection :crids, :class => BBC::Redux::Crid do
          property :content
          property :description
          property :type
        end
      end

      class Channel < Representable::Decorator
        include Representable::JSON
        property :category_id, :as => :category
        property :display_name, :as => :longname
        property :name
        property :sortorder
      end

      class Channels < Representable::Decorator
        include Representable::JSON::Collection
        items extend: Channel, class: BBC::Redux::Channel
      end

      class ChannelCategory < Representable::Decorator
        include Representable::JSON
        property :description
        property :id
        property :priority
      end

      class ChannelCategories < Representable::Decorator
        include Representable::JSON::Collection
        items extend: ChannelCategory, class: BBC::Redux::ChannelCategory
      end

      class SearchResults < Representable::Decorator
        include Representable::JSON
        property :created_at, :as => :time
        property :offset
        property :query
        property :query_time, :as => :elapsed
        property :total,      :as => :total_found
        property :total_returned

        nested :results do
          collection :assets, :extend => Asset, :class => BBC::Redux::Asset
        end
      end

      class User < Representable::Decorator
        include Representable::JSON

        property :can_invite
        property :created
        property :id
        property :uuid

        collection :permitted_services

        nested :details do
          property :department
          property :division
          property :email
          property :name
          property :username
        end

        nested :legal do
          property :legal_accepted, :as => :accepted
          property :legal_html
        end

      end

    end

  end
end

