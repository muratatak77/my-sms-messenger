ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mongoid"
require "database_cleaner/mongoid"
include ActiveJob::TestHelper

Rails.application.config.active_job.queue_adapter = :test

DatabaseCleaner[:mongoid].strategy = :deletion

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Add more helper methods to be used by all tests here...
    setup { DatabaseCleaner[:mongoid].start }
    teardown { DatabaseCleaner[:mongoid].clean }
  end
end
