# frozen_string_literal: true

require 'support/shared_examples/requests'

RSpec.describe '/api/reviews' do
  let!(:user) { create :user }
  let!(:book) { create :book }
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  include_examples 'requests', 'review'

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an review' do
        new_review = create(:review)
        get api_review_path(new_review)

        expect(response).to serialize_object(new_review).with(ReviewSerializer)
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_review_path(-1)
        expect(response).to be_not_found
      end
    end
  end

  describe 'POST to /' do
    context 'when successful' do
      let(:params) do
        {
          rating: 3,
          description: 'Meh.',
          user_id: user.id,
          book_id: book.id
        }
      end

      it 'creates a review' do
        expect { post api_reviews_path, params: params }.to change { Review.count }.by(1)

        expect(response).to have_http_status(:success)
      end

      it 'returns the created review' do
        post api_reviews_path, params: params

        expect(response_hash).to include(params)
        expect(response.status).to eq(200)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          rating: 3,
          user_id: -1
        }
      end

      it 'returns an error' do
        post api_reviews_path, params: params

        expect(response_hash).to eq(
          { errors: ['User must exist', 'Book must exist'] }
        )
      end
    end
  end

  describe 'PUT to /:id' do
    let(:review) { create(:review) }

    context 'when successful' do
      let(:params) do
        { rating: 5 }
      end

      it 'updates an existing review' do
        put api_review_path(review), params: params
        expect(review.reload.rating).to eq(params[:rating])
      end

      it 'returns the updated review' do
        put api_review_path(review), params: params
        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        { rating: '' }
      end

      it 'returns an error' do
        put api_review_path(review), params: params

        expect(response_hash).to eq(
          { errors: ['Rating not within the permitted range of 1 to 5.'] }
        )
      end
    end
  end
end
