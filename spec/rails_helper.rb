$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'zohoho'
require 'byebug'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec do |expectation|
    expectation.syntax = :expect
  end

  config.raise_errors_for_deprecations!
end

def vcr_configure(dir_name)
  VCR.configure do |config|
    config.cassette_library_dir = "spec/vcr_cassettes/#{dir_name}"
    config.hook_into(:webmock)
    config.default_cassette_options = { record: :none }
    config.allow_http_connections_when_no_cassette = true
  end
end
