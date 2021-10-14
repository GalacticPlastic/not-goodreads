# frozen_string_literal: true

require 'support/shared_examples/requests'

RSpec.describe '/api/books' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  include_examples 'requests', 'book'

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an book' do
        book = create(:book)
        get api_book_path(book)

        expect(response).to serialize_object(book).with(BookSerializer)
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_book_path(-1)

        expect(response).to be_not_found
      end
    end
  end

  describe 'POST to /' do
    context 'when successful' do
      let(:author) { create(:author) }
      let(:params) do
        {
          title: 'War and Peace',
          description: 'It was the best of times',
          author_id: author.id
        }
      end

      it 'creates a book' do
        expect { post api_books_path, params: params }.to change { Book.count }.by(1)
      end

      it 'returns the created book' do
        post api_books_path, params: params

        expect(response_hash).to include(params)
        expect(response.status).to eq(200)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          description: 'It was the best of times',
          title: 'War and Peace',
          author_id: -1
        }
      end

      it 'returns an error' do
        post api_books_path, params: params

        expect(response_hash).to eq(
          {
            errors: ['Author must exist']
          }
        )
      end
    end
  end

  describe 'PUT to /:id' do
    let(:book) { create(:book) }

    context 'when successful' do
      let(:params) do
        {
          description: 'I do not like green eggs and ham'
        }
      end

      it 'updates an existing book' do
        put api_book_path(book), params: params

        expect(book.reload.description).to eq(params[:description])
      end

      it 'returns the updated book' do
        put api_book_path(book), params: params

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
        put api_book_path(book), params: params

        expect(response_hash).to eq(
          {
            errors: ['Description can\'t be blank']
          }
        )
      end
    end
  end
end
