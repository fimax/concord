# frozen_string_literal: true

require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do |a,b,c|
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:example) do |example|
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:example) do
    DatabaseCleaner.clean
  end
end
