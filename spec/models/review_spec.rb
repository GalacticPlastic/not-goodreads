# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Review, type: :model do
  let(:review) { create(:review) }

  context 'validations' do
    it 'passes all' do
      expect(review.valid?).to eq(true)
    end

    describe '.rating' do
      it 'fails presence validation' do
        review.rating = nil
        expect(review.valid?).to eq(false)
      end

      it 'fails inclusion validation' do
        review.rating = 10
        expect(review.valid?).to eq(false)
      end
    end
  end

  # TODO: Update Test
  # describe '.update_average_book_rating' do
  #   let(:user1) { create(:user) }
  #   let(:user1) { create(:user) }
  #   let(:book) { create(:book) }
  #   let(:review1) { create(:review, rating: 1, user_id: user1.id, book_id: book.id) }
  #   let(:review2) { create(:review, rating: 3, user_id: user2.id, book_id: book.id) }

  #   after(:create) do
  #     puts book.rating
  #     it 'updates the book rating' do
  #       book.rating.should eq(2)
  #     end
  #   end
  # end
end
