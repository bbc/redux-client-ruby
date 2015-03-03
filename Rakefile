################################################################################
# Test Tasks

task :default => :spec

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/bbc/**/*_spec.rb']
end

desc 'Run integration tests (requires redux login)'
RSpec::Core::RakeTask.new(:integration) do |spec|
  spec.pattern = FileList['spec/integration/**/*_spec.rb']
end

desc 'Open coverage report'
task :coverage do
  sh 'open coverage/index.html'
end

desc 'Open IRB with library loaded'
task :console do
  sh 'irb -Ilib -r bbc/redux'
end

################################################################################
# Documentation Tasks

require 'yard'

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = [ 'lib/bbc/**/*.rb' ]
  t.options = [
    '--no-private',
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

