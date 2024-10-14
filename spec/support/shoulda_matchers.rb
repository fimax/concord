include Shoulda::Matchers::ActiveRecord
extend Shoulda::Matchers::ActiveRecord
include Shoulda::Matchers::ActiveModel
extend Shoulda::Matchers::ActiveModel

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework(:rspec)
    with.library(:rails)
  end
end

RSpec::Matchers.define_negated_matcher(:not_change, :change)
