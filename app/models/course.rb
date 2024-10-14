class Course < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  has_many :course_competences, dependent: :destroy
  has_many :competences, through: :course_competences
  belongs_to :author
end
