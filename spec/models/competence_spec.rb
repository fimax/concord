require 'rails_helper'

RSpec.describe Competence, type: :model do
  it 'validations', :aggregate_failures do
    is_expected.to validate_presence_of(:name)
  end

  it 'associations', :aggregate_failures do
    is_expected.to have_many(:course_competences).dependent(:destroy)
    is_expected.to have_many(:courses).through(:course_competences)
  end
end
