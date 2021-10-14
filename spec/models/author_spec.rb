# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Author, type: :model do
  let(:author) { create(:author) }

  context 'validations' do
    it 'passes all' do
      expect(author.valid?).to eq(true)
    end

    describe '.description' do
      it 'fails presence validation' do
        author.description = nil
        expect(author.valid?).to eq(false)
      end
    end
  end
end
