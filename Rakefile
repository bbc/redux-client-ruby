################################################################################
# Test Tasks

task :default => :spec

require 'rspec/core/rake_task'

integration_tests = FileList['spec/integration/*_spec.rb']
unit_tests        = FileList['spec/**/*_spec.rb'] - integration_tests

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = unit_tests
end

desc 'Run integration tests (requires redux login)'
RSpec::Core::RakeTask.new(:integration) do |spec|
  spec.pattern = integration_tests
end

desc 'Open coverage report'
task :coverage do
  sh 'open coverage/index.html'
end

################################################################################
# Documentation Tasks

require 'yard'

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = [ 'lib/**/*.rb' ]
  t.options = [
    '--output-dir', 'docs/yard',
    '--readme', 'README.md'
  ]
end

################################################################################
# Gem building Tasks

namespace :gem do

  desc 'Build gem file'
  task :build do
    sh 'bundle exec gem build bbc_redux.gemspec'
  end

end

