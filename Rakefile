require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = 'zohoho'
  gem.homepage = 'http://github.com/kwhite/zohoho'
  gem.license = 'MIT'
  gem.summary = %(Simple interface to zoho api)
  gem.description = %(Simple interface to zoho api)
  gem.email = %w[jkentonwhite@gmail.com, nicholas.martin@marketdojo.com]
  gem.authors = %w[KentonWhite NicholasMartin Xymist]
  gem.version = '4.1.0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task default: :test
