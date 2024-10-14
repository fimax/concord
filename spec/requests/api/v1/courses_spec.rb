require 'swagger_helper'

RSpec.describe 'api/v1/courses', type: :request do
  shared_context 'after test' do
    after do |example|
      content = example.metadata[:response][:content] || {}
      example_spec = {
        'application/json'=>{
          examples: {
            test_example: {
              value: JSON.parse(response.body, symbolize_names: true)
            }
          }
        }
      }
      example.metadata[:response][:content] = content.deep_merge(example_spec)
    end
  end

  let!(:competence_1) { create(:competence) }
  let!(:competence_2) { create(:competence) }
  let!(:competence_3) { create(:competence) }

  path '/api/v1/courses' do
    get('retrieves courses') do
      tags 'Courses'
      consumes 'application/json'
      produces 'application/json'
      description 'Retrieves courses.'

      parameter name: :page, in: :path, type: :integer, description: 'Page number'

      response(200, 'successful') do
        schema type: :array, items: { '$ref' => '#/components/schemas/course' }

        let!(:course_1) { create(:course, competences: [competence_1, competence_2]) }
        let!(:course_2) { create(:course, competences: [competence_1]) }
        let!(:course_3) { create(:course, competences: []) }
        let(:page) { 1 }

        include_context 'after test'

        run_test!
      end
    end

    post('create course') do
      tags 'Courses'
      consumes 'application/json'
      produces 'application/json'
      description 'Create a new course.'

      parameter name: :course, in: :body, schema: { '$ref' => '#/components/schemas/course' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/course'

        let(:author) { create(:author) }

        let(:course) {
          {
            name: 'Programming',
            description: 'Some tutorial',
            author_id: author.id,
            competence_ids: [competence_1.id, competence_2.id]
          }
        }

        include_context 'after test'

        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    get('show course') do
      tags 'Courses'
      produces 'application/json'
      description 'Get the details for a particular course'
      parameter name: :id, in: :path, type: :integer, description: 'The ID for the course'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/course'

        let(:course_record) { create(:course, competences: [competence_1, competence_2]) }
        let(:id) { course_record.id }

        include_context 'after test'

        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/not_found'

        let(:id) { 999999999 }

        include_context 'after test'

        run_test!
      end
    end

    put('update course') do
      tags 'Courses'
      consumes 'application/json'
      produces 'application/json'
      description 'Update an course'

      parameter name: :id, in: :path, type: :integer, description: 'The ID for the course'
      parameter name: :course, in: :body, schema: { '$ref' => '#/components/schemas/course' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/course'

        let(:course_record) { create(:course, competences: [competence_1, competence_2]) }

        let(:id) { course_record.id }
        let(:course) {
          {
            name: 'Programming',
            description: 'Some tutorial',
            competence_ids: [competence_2.id, competence_3.id]
          }
        }

        include_context 'after test'

        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/not_found'

        let(:id) { 999999999 }
        let(:course) {
          {
            name: 'Programming',
            description: 'Some tutorial',
            competence_ids: [competence_2.id, competence_3.id]
          }
        }

        include_context 'after test'

        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/unprocessable_entity'

        let(:course_record) { create(:course, competences: [competence_1, competence_2]) }

        let(:id) { course_record.id }
        let(:course) {
          {
            name: 'Programming',
            description: nil,
            competence_ids: [competence_2.id, competence_3.id]
          }
        }

        include_context 'after test'

        run_test!
      end
    end

    delete('delete course') do
      tags 'Courses'
      consumes 'application/json'
      produces 'application/json'
      description 'Delete an course'

      parameter name: :id, in: :path, type: :integer, description: 'The ID for the course'

      response(204, 'successful') do
        let(:course_record) { create(:course, competences: [competence_1, competence_2]) }
        let(:id) { course_record.id }

        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/not_found'

        let(:id) { 999999999 }

        include_context 'after test'

        run_test!
      end
    end
  end
end
