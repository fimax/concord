class CourseCompetence < ApplicationRecord
  validates :course_id, uniqueness: { scope: [:competence_id] }

  belongs_to :course
  belongs_to :competence
end
