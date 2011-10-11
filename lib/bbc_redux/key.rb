module BBC
  module Redux
    class Key

      attr_reader :value, :created_at

      def initialize(value)
        @value      = value
        @created_at = Time.now
      end

      def expires_at
        created_at + (60 * 60 * 24)
      end

      def expired?
        expires_at <= Time.now
      end

      def valid?
        !expired?
      end

    end
  end
end