# -*- encoding: utf-8 -*-

$: << File.join( File.dirname(__FILE__), 'lib' )

require 'rake'
require 'bbc/redux/version'

Gem::Specification.new do |gem|

  # Meta data

  gem.name        = 'bbc_redux'
  gem.version     = BBC::Redux::VERSION
  gem.summary     = 'A Ruby client for BBC Redux',
  gem.description = 'A gem to help navigate the BBC Redux API'
  gem.homepage    = 'https://www.bbcredux.com'
  gem.license     = 'Apache'

  gem.authors     = [
    'JamesHarrison',
    'andhapp',
    'matth'
  ]

  gem.email       = [
    'james.harrison@bbc.co.uk',
    'matt.haynes@bbc.co.uk'
  ]

  # Files / paths

  gem.executables << 'bbc-redux'

  gem.files       = FileList[
    'AUTHORS',
    'COPYING',
    'Gemfile',
    'README.md',
    'Rakefile',
    'bbc_redux.gemspec',
    'bin/*',
    'lib/**/*'
  ]

  gem.test_files    = FileList[ 'spec/**/*' ]

  gem.require_paths = [ 'lib' ]

  # Development dependencies

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'simplecov', '>= 0.8.2'
  gem.add_development_dependency 'yard'

  # Runtime dependencies

  gem.add_dependency 'multi_json'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'representable', '>= 2.4'
  gem.add_dependency 'terminal-table'
  gem.add_dependency 'typhoeus', '>= 0.6.8'
  gem.add_dependency 'virtus', '>= 0.5.0'

end

