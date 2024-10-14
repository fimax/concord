class Competence < ApplicationRecord
  validates :name, presence: true

  has_many :course_competences, dependent: :destroy
  has_many :courses, through: :course_competences
end
