require "typhoeus"
require "bbc_redux/exceptions"

module BBC
  class Redux
    module Http

      include BBC::Redux::Exceptions

      def get(url, opts = {})
        Typhoeus::Request.get(url, opts.merge( :follow_location => true ) )
      end

      def head(url, opts = {})
        Typhoeus::Request.head(url, opts)
      end

      def head_page(url, token)
        response = head url, :headers => cookie_request_header(token)
        unless response.code == 200
          http_error(response)
        end
      end

      protected

      def get_page(url, token)
        response = get url, :headers => cookie_request_header(token)
        case response.code
          when 200
            raise SessionInvalidException.new("Session invalid, can't connect to #{url}") if response.body =~ /Please log in/
            response
          else
            http_error(response)
        end
      end

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

      def cookie_request_header(token)
        {:Cookie => "BBC_video=#{token}"}
      end
    end
  end
end
