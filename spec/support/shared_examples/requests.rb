# frozen_string_literal: true

require 'rails_helper'
RSpec.shared_examples 'requests' do |klass|
  let(:response_hash) { JSON(response.body, symbolize_names: true) }
  # object = Kernel.const_get(klass.capitalize)

  describe "GET /#{klass.pluralize}" do
    it "returns all #{klass.pluralize}" do
      create_list(klass.to_sym, 5)
      get "/api/#{klass.pluralize}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(response_hash.size).to eq(5)
    end
  end
end
