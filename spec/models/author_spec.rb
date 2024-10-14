require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'validations', :aggregate_failures do
    is_expected.to validate_presence_of(:first_name)
    is_expected.to validate_presence_of(:last_name)
  end

  it 'associations', :aggregate_failures do
    is_expected.to have_many(:courses)
  end

  describe '::search_by_competence' do
    let!(:competence_1) { create(:competence) }
    let!(:competence_2) { create(:competence) }
    let!(:competence_3) { create(:competence) }

    let!(:author_1) { create(:author) }
    let!(:course_1_1) { create(:course, author: author_1, competences: [competence_1, competence_2, competence_3]) }
    let!(:course_1_2) { create(:course, author: author_1, competences: [competence_1, competence_2]) }
    let!(:course_1_3) { create(:course, author: author_1, competences: [competence_2]) }

    let!(:author_2) { create(:author) }
    let!(:course_2_1) { create(:course, author: author_2, competences: [competence_2]) }
    let!(:course_2_2) { create(:course, author: author_2, competences: [competence_3]) }

    let!(:author_3) { create(:author) }
    let!(:course_3_1) { create(:course, author: author_3, competences: [competence_1]) }
    let!(:course_3_2) { create(:course, author: author_3, competences: [competence_2]) }

    it 'should find authors by their competence', :aggregate_failures do
      expect(described_class.search_by_competence([competence_1.id])).to contain_exactly(author_1, author_3)
      expect(described_class.search_by_competence([competence_2.id])).to contain_exactly(author_1, author_2, author_3)
      expect(described_class.search_by_competence([competence_3.id])).to contain_exactly(author_1, author_2)
      expect(described_class.search_by_competence([competence_1.id, competence_3.id])).to contain_exactly(author_1, author_2, author_3)
    end
  end
end
