require "bbc_redux/http"

module BBC
  class Redux
    class Client
      include Http

      def login(username, password)
        url = Url.login(username, password)
        user_request(url) do |response|
          User.from_xml(response.body)
        end
      end

      def logout(session)
        url = Url.logout(session.token)
        user_request(url)
      rescue ClientHttpException
      end

      def content(disk_reference, session)
        url = Url.content(disk_reference, session.token)
        content_request(url) do |response|
          Content.from_xml(response.body)
        end
      end

      def key(disk_reference, session)
        url = Url.key(disk_reference, session.token)
        content_request(url) do |response|
          Key.from_xml(response.body)
        end
      end

      def tv_schedule(date, session)
        url      = Url.tv_schedule(date)
        response = get_page(url, session.token)
        Schedule.from_tv_html(response.body)
      end

      def ping(session)
        head_page(Url.ping, session.token)
      end
    end
  end
end
