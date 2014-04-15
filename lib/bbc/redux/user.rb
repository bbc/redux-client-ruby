require 'virtus'

module BBC
  module Redux

    # Redux API User Object
    #
    # @example Properties of the user object
    #
    #   user = redux_client.user
    #
    #   user.admin?       #=> Boolean
    #   user.can_invite?  #=> Boolean
    #   user.created      #=> DateTime
    #   user.email        #=> String
    #   user.first_name   #=> String
    #   user.id           #=> Integer
    #   user.last_name    #=> String
    #   user.username     #=> String
    #   user.uuid         #=> String
    #
    # @example Check if user can proceed or needs to sign T&C's
    #
    #   if user.must_sign_terms?
    #     puts "Hey #{user.name}, you need to sign these terms"
    #     puts user.legal_html
    #   end
    #
    # @author Matt Haynes <matt.haynes@bbc.co.uk>
    class User

      include Virtus.value_object

      # @!attribute [r] admin
      # @return [Boolean] whether the user is an admin
      attribute :admin, Boolean

      alias :admin? :admin

      # @!attribute [r] can_invite
      # @return [Boolean] whether the user has ability to invite others to Redux
      attribute :can_invite, Boolean

      alias :can_invite? :can_invite

      # @!attribute [r] created
      # @return [DateTime] the date on which user account was created
      attribute :created,  DateTime

      # @!attribute [r] department
      # @return [String] the user's organisational department
      attribute :department, String, :default => ''

      # @!attribute [r] division
      # @return [String] the user's organisational division
      attribute :division, String, :default => ''

      # @!attribute [r] email
      # @return [String] the user's email
      attribute :email, String, :default => ''

      # @!attribute [r] id
      # @return [Integer] the user's id
      attribute :id, Integer

      # @!attribute [r] legal_accepted
      # @see User#must_sign_terms?
      # @return [String] whether the user has accepted the T&C's
      attribute :legal_accepted, Boolean, :default => true

      # @!attribute [r] legal_html
      # @return [String] a blob of T&C's HTML that the user may need to accept
      attribute :legal_html, String, :default => ''

      # @!attribute [r] name
      # @return [String] the user's full name
      attribute :name, String, :default => ''

      # @!attribute [r] permitted_services
      # @return [Array<String>] a list of services user has access to
      attribute :permitted_services, Array[String], :default => []

      # @!attribute [r] username
      # @return [String] the user's username
      attribute :username, String, :default => ''

      # @!attribute [r] uuid
      # @return [String] the user's uuid
      attribute :uuid, String

      # @!attribute [r] first_name
      # @return [String] the user's first name
      def first_name
        name.split(' ').first
      end

      # @!attribute [r] last_name
      # @return [String] the user's last name
      def last_name
        name.split(' ').last
      end

      # @!attribute [r] must_sign_terms?
      # @see User#legal_accepted
      # @see User#legal_html
      # @return [String] whether the user must sign some T&C's before proceeding
      def must_sign_terms?
        !legal_accepted
      end

    end

  end
end
