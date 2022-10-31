# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)

require 'rubygems'
require 'simplecov'
require 'rspec/rails'
require 'factory_bot'
require 'shoulda/matchers'
require 'database_cleaner'
require 'faker'
require 'rspec/core'
require 'rspec/expectations'
require 'rspec/mocks'
require 'rake'
require 'rspec/retry'
require "mock_redis"

SimpleCov.start('rails') do
  coverage_dir('public/coverage')
end

Rails.env = 'development' #TODO change
require File.expand_path('../config/environment', __dir__)

FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.raise_errors_for_deprecations!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior     = :apply_to_host_groups
  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.default_formatter                    = 'doc' if config.files_to_run.one?
  config.order                                = :defined

  Shoulda::Matchers.configure do |conf|
    conf.integrate do |with|
      with.test_framework(:rspec)
      with.library(:rails)
    end
  end

  config.verbose_retry                = false
  config.display_try_failure_messages = true
  
  config.before(:each) do
    mock_redis = MockRedis.new
    allow(Redis).to receive(:new).and_return(mock_redis)
  end
end
