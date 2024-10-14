require 'swagger_helper'

RSpec.describe 'api/v1/authors', type: :request do
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

  path '/api/v1/authors' do
    get('retrieves authors') do
      tags 'Authors'
      consumes 'application/json'
      produces 'application/json'
      description 'Retrieves authors.'

      parameter name: :competence_id, in: :path, type: :array, items: { type: :integer }, description: 'Competence IDs'
      parameter name: :page, in: :path, type: :integer, description: 'Page number'

      response(200, 'successful') do
        schema type: :array, items: { '$ref' => '#/components/schemas/author' }

        let!(:competence_1) { create(:competence) }
        let!(:competence_2) { create(:competence) }

        let!(:author_1) { create(:author) }
        let!(:course_1_2) { create(:course, author: author_1, competences: [competence_1, competence_2]) }
        let!(:course_1_3) { create(:course, author: author_1, competences: [competence_2]) }

        let!(:author_2) { create(:author) }
        let!(:course_2_1) { create(:course, author: author_2, competences: [competence_2]) }

        let!(:author_3) { create(:author) }
        let!(:course_3_1) { create(:course, author: author_3, competences: [competence_1]) }

        let(:competence_id) { [competence_1.id] }
        let(:page) { 1 }

        include_context 'after test'

        run_test!
      end
    end

    post('create author') do
      tags 'Authors'
      consumes 'application/json'
      produces 'application/json'
      description 'Create a new author.'

      parameter name: :author, in: :body, schema: { '$ref' => '#/components/schemas/author' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/author'

        let(:author) { { first_name: 'Test', last_name: 'Author' } }

        include_context 'after test'

        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    get('show author') do
      tags 'Authors'
      produces 'application/json'
      description 'Get the details for a particular author'
      parameter name: :id, in: :path, type: :integer, description: 'The ID for the author'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/author'

        let(:author_record) { create(:author, first_name: 'Test', last_name: 'Author') }
        let(:id) { author_record.id }

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

    put('update author') do
      tags 'Authors'
      consumes 'application/json'
      produces 'application/json'
      description 'Update an author'

      parameter name: :id, in: :path, type: :integer, description: 'The ID for the author'
      parameter name: :author, in: :body, schema: { '$ref' => '#/components/schemas/author' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/author'

        let(:author_record) { create(:author, first_name: 'Previous', last_name: 'Name') }

        let(:id) { author_record.id }
        let(:author) { { first_name: 'New', last_name: 'Name' } }

        include_context 'after test'

        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/not_found'

        let(:id) { 999999999 }
        let(:author) { { first_name: 'New', last_name: 'Name' } }

        include_context 'after test'

        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/unprocessable_entity'

        let(:author_record) { create(:author, first_name: 'Previous', last_name: 'Name') }

        let(:id) { author_record.id }
        let(:author) { { first_name: 'New', last_name: nil } }

        include_context 'after test'

        run_test!
      end
    end

    delete('delete author') do
      tags 'Authors'
      consumes 'application/json'
      produces 'application/json'
      description 'Delete an author'

      parameter name: :id, in: :path, type: :integer, description: 'The ID for the author'

      response(204, 'successful') do
        let(:author_record) { create(:author, first_name: 'Previous', last_name: 'Name') }
        let(:id) { author_record.id }

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
