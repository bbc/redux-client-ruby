module BBC
  module Redux
    class Session

      attr_reader :token, :created_at

      def initialize(token)
        @token      = token
        @created_at = Time.now
      end

    end
  end
end
