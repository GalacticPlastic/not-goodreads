# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Book, type: :model do
  let(:book) { create(:book) }

  context 'validations' do
    it 'passes all' do
      expect(book.valid?).to eq(true)
    end

    describe '.title' do
      it 'fails presence validation' do
        book.title = nil
        expect(book.valid?).to eq(false)
      end
    end

    describe '.description' do
      it 'fails presence validation' do
        book.description = nil
        expect(book.valid?).to eq(false)
      end
    end
  end
end
