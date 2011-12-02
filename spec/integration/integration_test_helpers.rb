require "spec_helper"

module IntegrationTestHelpers

  def ask(question, quietly = false)
    print question
    system "stty -echo" if quietly
    answer = $stdin.gets.chomp
    system "stty echo" if quietly
    return answer
  end

  def username
    @@username ||= ask("Please enter redux user: ")
  end

  def password
    @@password ||= ask("Please enter redux pass: ", true)
  end

  def client
    BBC::Redux::Client.new
  end

  def login_and(&block)
    user = client.login(username, password)
    block.call(user)
    client.logout(user.session)
  end

end

class Trigger
  include IntegrationTestHelpers
end

Trigger.new.username
Trigger.new.password