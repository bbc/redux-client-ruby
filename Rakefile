require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "bbc_redux"
  gem.homepage = "http://github.com/bbcsnippets/redux-client-ruby"
  gem.license = "MIT"
  gem.summary = %Q{A Ruby client for BBC Redux}
  gem.description = %Q{A gem to help navigate the Redux API's and to screen scrape where an API does not exist}
  gem.email = "matt.haynes@bbc.co.uk"
  gem.authors = ["matth"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb'] - FileList['spec/integration/*_spec.rb']
end

desc "Run integration tests (requires redux login)"
RSpec::Core::RakeTask.new(:integration) do |spec|
  spec.pattern = FileList['spec/integration/*_spec.rb']
end

desc "Generate coverage"
task :coverage do
  require "cover_me"
  CoverMe.complete!
end

task :default => :spec
