require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'validations', :aggregate_failures do
    is_expected.to validate_presence_of(:name)
    is_expected.to validate_presence_of(:description)
  end

  it 'associations', :aggregate_failures do
    is_expected.to have_many(:course_competences).dependent(:destroy)
    is_expected.to have_many(:competences).through(:course_competences)
    is_expected.to belong_to(:author)
  end
end
