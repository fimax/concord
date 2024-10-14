require 'rails_helper'

RSpec.describe CourseCompetence, type: :model do
  it 'validations', :aggregate_failures do
    course_competence = build :course_competence
    expect(course_competence).to validate_uniqueness_of(:course_id).scoped_to(:competence_id)
  end

  it 'associations', :aggregate_failures do
    is_expected.to belong_to(:course)
    is_expected.to belong_to(:competence)
  end
end
