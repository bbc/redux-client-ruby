require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

$: << File.join( File.dirname(__FILE__), '..', 'lib' )

require 'rspec'
require 'rspec/its'
require 'bbc/redux'

RSpec.configure do |config|
  config.order = 'random'

  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  def read_fixture(fname)
    File.read File.join( File.dirname(__FILE__), 'fixtures', fname )
  end

end
