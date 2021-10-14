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
end
