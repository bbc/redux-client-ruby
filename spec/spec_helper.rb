require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'rspec'
require 'bbc_redux'

RSpec.configure do |config|
  config.order = 'random'

  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
