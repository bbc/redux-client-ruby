# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bbc_redux"
  s.version = "0.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["matth", "andhapp", "JamesHarrison"]
  s.date = "2013-04-08"
  s.description = "A gem to help navigate the Redux API's and to screen scrape where an API does not exist"
  s.email = "matt.haynes@bbc.co.uk"
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".rspec",
    "AUTHORS",
    "COPYING",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "VERSION",
    "bbc_redux.gemspec",
    "lib/bbc_redux.rb",
    "lib/bbc_redux/client.rb",
    "lib/bbc_redux/content.rb",
    "lib/bbc_redux/exceptions.rb",
    "lib/bbc_redux/http.rb",
    "lib/bbc_redux/key.rb",
    "lib/bbc_redux/schedule.rb",
    "lib/bbc_redux/session.rb",
    "lib/bbc_redux/url.rb",
    "lib/bbc_redux/user.rb",
    "spec/bbc_redux/client_spec.rb",
    "spec/bbc_redux/content_spec.rb",
    "spec/bbc_redux/http_spec.rb",
    "spec/bbc_redux/key_spec.rb",
    "spec/bbc_redux/schedule_spec.rb",
    "spec/bbc_redux/session_spec.rb",
    "spec/bbc_redux/url_spec.rb",
    "spec/bbc_redux/user_spec.rb",
    "spec/bbc_redux_spec.rb",
    "spec/fixtures/radio_programme.html",
    "spec/fixtures/radio_schedule.html",
    "spec/fixtures/tv_schedule.html",
    "spec/integration/core_api_spec.rb",
    "spec/integration/integration_test_helpers.rb",
    "spec/integration/sugar_api_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/bbcrd/redux-client-ruby"
  s.licenses = ["Apache"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "A Ruby client for BBC Redux"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typhoeus>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<fuubar>, [">= 0"])
      s.add_development_dependency(%q<cover_me>, [">= 0"])
    else
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<fuubar>, [">= 0"])
      s.add_dependency(%q<cover_me>, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<fuubar>, [">= 0"])
    s.add_dependency(%q<cover_me>, [">= 0"])
  end
end

