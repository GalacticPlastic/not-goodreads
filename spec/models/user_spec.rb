# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'validations' do
    it 'passes all' do
      expect(user.valid?).to eq(true)
    end

    describe '.first_name' do
      it 'fails presence validation' do
        user.first_name = nil
        expect(user.valid?).to eq(false)
      end
    end

    describe '.last_name' do
      it 'fails presence validation' do
        user.last_name = nil
        expect(user.valid?).to eq(false)
      end
    end
  end
end
