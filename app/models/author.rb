class Author < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :courses

  scope :search_by_competence, -> (competence_id = []) { joins(courses: :competences).where(courses: { competences: { id: competence_id } }).distinct }
end
