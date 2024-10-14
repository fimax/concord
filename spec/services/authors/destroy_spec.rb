require 'rails_helper'

RSpec.describe Authors::Destroy, type: :service do
  describe '#call' do
    let(:author_1) { create(:author) }
    let(:author_2) { create(:author) }

    let!(:course_1_1) { create(:course, author: author_1) }
    let!(:course_1_2) { create(:course, author: author_1) }
    let!(:course_2_1) { create(:course, author: author_2) }

    subject { described_class.new.call(author_1) }

    context 'when the author is successfully deleted' do
      it "returns 'success' = 'true'" do
        expect(subject).to eq({
          success: true,
          errors:  []
        })
      end

      it "assigns authour's courses to another author" do
        expect { subject }.to change { course_1_1.reload.author_id }.from(author_1.id).to(author_2.id)
          .and change { course_1_2.reload.author_id }.from(author_1.id).to(author_2.id)
      end
    end

    context 'when the author has not been deleted' do
      before do
        allow(author_1).to receive(:destroy).and_return(false)
        allow(author_1).to receive_message_chain(:errors, :full_messages).and_return(['Some error'])
      end

      it "returns 'success' = 'false' and error messages" do
        expect(subject).to eq({
          success: false,
          errors:  ['Some error']
        })
      end

      it "doesn't change author's courses" do
        expect { subject }.to not_change { course_1_1.reload.author_id }
        .and not_change { course_1_2.reload.author_id }
      end
    end
  end
end
