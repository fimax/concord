FactoryBot.define do
  factory :course_competence do
    course     { create :course }
    competence { create :competence }
  end
end
