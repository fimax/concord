require 'swagger_helper'

RSpec.describe 'api/v1/competences', type: :request do
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

  path '/api/v1/competences' do
    get('retrieves competences') do
      tags 'Competences'
      consumes 'application/json'
      produces 'application/json'
      description 'Retrieves competences.'

      parameter name: :page, in: :path, type: :integer, description: 'Page number'

      response(200, 'successful') do
        schema type: :array, items: { '$ref' => '#/components/schemas/competence' }

        let!(:competence_1) { create(:competence) }
        let!(:competence_2) { create(:competence) }
        let!(:competence_3) { create(:competence) }
        let(:page) { 1 }

        include_context 'after test'

        run_test!
      end
    end

    post('create competence') do
      tags 'Competences'
      consumes 'application/json'
      produces 'application/json'
      description 'Create a new competence.'

      parameter name: :competence, in: :body, schema: { '$ref' => '#/components/schemas/competence' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/competence'

        let(:competence) { { name: 'Programming' } }

        include_context 'after test'

        run_test!
      end
    end
  end

  path '/api/v1/competences/{id}' do
    get('show competence') do
      tags 'Competences'
      produces 'application/json'
      description 'Get the details for a particular competence'
      parameter name: :id, in: :path, type: :integer, description: 'The ID for the competence'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/competence'

        let(:competence_record) { create(:competence, name: 'Programming') }
        let(:id) { competence_record.id }

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

    put('update competence') do
      tags 'Competences'
      consumes 'application/json'
      produces 'application/json'
      description 'Update an competence'

      parameter name: :id, in: :path, type: :integer, description: 'The ID for the competence'
      parameter name: :competence, in: :body, schema: { '$ref' => '#/components/schemas/competence' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/competence'

        let(:competence_record) { create(:competence, name: 'Programming') }

        let(:id) { competence_record.id }
        let(:competence) { { name: 'Coding' } }

        include_context 'after test'

        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/not_found'

        let(:id) { 999999999 }
        let(:competence) { { name: 'Coding' } }

        include_context 'after test'

        run_test!
      end

      response(422, 'unprocessable entity') do
        schema '$ref' => '#/components/schemas/unprocessable_entity'

        let(:competence_record) { create(:competence, name: 'Programming') }

        let(:id) { competence_record.id }
        let(:competence) { { name: nil } }

        include_context 'after test'

        run_test!
      end
    end

    delete('delete competence') do
      tags 'Competences'
      consumes 'application/json'
      produces 'application/json'
      description 'Delete an competence'

      parameter name: :id, in: :path, type: :integer, description: 'The ID for the competence'

      response(204, 'successful') do
        let(:competence_record) { create(:competence, name: 'Programming') }
        let(:id) { competence_record.id }

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
