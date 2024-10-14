require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'validations', :aggregate_failures do
    is_expected.to validate_presence_of(:first_name)
    is_expected.to validate_presence_of(:last_name)
  end

  it 'associations', :aggregate_failures do
    is_expected.to have_many(:courses)
  end
end
