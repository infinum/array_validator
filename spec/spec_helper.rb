require 'simplecov'
SimpleCov.start do
  add_filter { |src| src.filename =~ /spec/ }
end

require 'bundler/setup'
require 'pry'
require 'array_validator'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
