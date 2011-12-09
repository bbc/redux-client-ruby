if RUBY_VERSION.match("1.9")
  require "cover_me"

  CoverMe.config.project.root = File.join(File.dirname(__FILE__), '..')
  CoverMe.config.file_pattern = /redux/
end

require 'rspec'
require 'bbc_redux'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end
