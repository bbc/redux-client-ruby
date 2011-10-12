module BBC
  module Redux
    module Exceptions

      # Wrong username
      class UserNotFoundException < Exception; end

      # Wrong password
      class UserPasswordException < Exception; end

      # Redux has marked you account as "comprimised". Too many concurrent logins
      class UserAccountLockedException < Exception; end

      # You session token was rejected
      class SessionInvalidException < Exception; end

      # You tried to get some data or a key for a disk reference that is unavailable
      class ContentNotFoundException < Exception; end

      # An HTTP error occurred
      class ClientHttpException < Exception; end

    end
  end
end
