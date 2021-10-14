# frozen_string_literal: true

require 'support/shared_examples/requests'

RSpec.describe '/api/authors' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  include_examples 'requests', 'author'

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an author' do
        new_author = create(:author)
        get api_author_path(new_author)

        expect(response).to serialize_object(new_author).with(AuthorSerializer)
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_author_path(-1)

        expect(response).to be_not_found
      end
    end
  end

  describe 'POST to /' do
    context 'when successful' do
      let(:params) do
        {
          description: 'Hop on pop',
          first_name: 'Dr.',
          last_name: 'Seuss',
          genres: ['Children\'s Books'],
          website: 'https://www.seussville.com'
        }
      end

      it 'creates an author' do
        expect { post api_authors_path, params: params }.to change { Author.count }.by(1)
      end

      it 'returns the created author' do
        post api_authors_path, params: params

        expect(response_hash).to include(params)
        expect(response.status).to eq(200)
      end
    end

    context 'when unsuccessful' do
      let(:params) {}

      it 'returns an error' do
        post api_authors_path, params: params

        expect(response_hash).to eq(
          {
            errors: ['Description can\'t be blank']
          }
        )
      end
    end
  end

  describe 'PUT to /:id' do
    let(:author) { create(:author) }

    context 'when successful' do
      let(:params) do
        {
          description: 'I do not like green eggs and ham'
        }
      end

      it 'updates an existing author' do
        put api_author_path(author), params: params

        expect(author.reload.description).to eq(params[:description])
      end

      it 'returns the updated author' do
        put api_author_path(author), params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          description: ''
        }
      end

      it 'returns an error' do
        put api_author_path(author), params: params

        expect(response_hash).to eq(
          {
            errors: ['Description can\'t be blank']
          }
        )
      end
    end
  end
end
