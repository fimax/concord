# frozen_string_literal: true

require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do |a,b,c|
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:example) do |example|
    is_feature_example = example.metadata[:type].eql?(:feature) || example.metadata[:feature].is_a?(TrueClass)
    current_strategy = is_feature_example ? [:deletion, except: %w(products services)] : :transaction

    DatabaseCleaner.strategy = current_strategy
    DatabaseCleaner.start
  end

  config.after(:example) do
    DatabaseCleaner.clean
  end
end
