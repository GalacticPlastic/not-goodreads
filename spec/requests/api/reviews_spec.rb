# frozen_string_literal: true

require 'support/shared_examples/requests'

RSpec.describe '/api/reviews' do
  let(:user) { create :user }
  let(:book) { create :book }
  # let!(:review) { create :review, book_id: book.id, user_id: user.id }
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  include_examples 'requests', 'review'

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an review' do
        new_review = create(:review, book_id: book.id, user_id: user.id)
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
end
