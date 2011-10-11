module BBC
  module Redux
    class User

      attr_reader :id, :username, :first_name, :last_name, :email, :session

      def initialize(attributes)
        attributes.each_pair do |key, val|
          self.instance_variable_set(:"@#{key}", val)
        end
      end

    end
  end
end