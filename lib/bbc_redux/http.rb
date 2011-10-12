require "typhoeus"
require "bbc_redux/exceptions"

module BBC
  module Redux
    module Http

      include BBC::Redux::Exceptions

      def get(url)
        Typhoeus::Request.get(url)
      end

      protected

      def user_request(url, &block)
        response = get url
        case response.code
          when 200
            block.call(response) if block_given?
          when 403
            raise UserPasswordException.new("Incorrect password")
          when 404
            raise UserNotFoundException.new("Incorrect username")
          else
            http_error(response)
        end
      end

      def content_request(url, &block)
        response = get url
        case response.code
          when 200
            block.call(response) if block_given?
          when 403
            raise SessionInvalidException.new("Session invalid, can't connect to #{url}")
          when 404
            raise ContentNotFoundException.new("Content not found for #{url}")
          else
            http_error(response)
        end
      end

      def http_error(response)
        raise ClientHttpException.new("#{response.code} response for #{response.effective_url}")
      end

    end
  end
end