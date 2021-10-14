# frozen_string_literal: true

require 'support/shared_examples/requests'

RSpec.describe '/api/users' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  include_examples 'requests', 'user'

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns an user' do
        user = create(:user)
        get api_user_path(user)

        expect(response).to serialize_object(user).with(UserSerializer)
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_user_path(-1)

        expect(response).to be_not_found
      end
    end
  end

  describe 'POST to /' do
    context 'when successful' do
      let(:params) do
        {
          first_name: 'Harry',
          last_name: 'Potter'
        }
      end

      it 'creates an user' do
        expect { post api_users_path, params: params }.to change { User.count }.by(1)
      end

      it 'returns the created user' do
        post api_users_path, params: params
        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) {}

      it 'returns an error' do
        post api_users_path, params: params

        expect(response_hash).to eq(
          {
            errors: [
              'First name can\'t be blank',
              'Last name can\'t be blank'
            ]
          }
        )
      end
    end
  end

  describe 'PUT to /:id' do
    let(:user) { create(:user) }

    context 'when successful' do
      let(:params) do
        {
          first_name: 'James'
        }
      end

      it 'updates an existing user' do
        put api_user_path(user), params: params

        expect(user.reload.first_name).to eq(params[:first_name])
      end

      it 'returns the updated user' do
        put api_user_path(user), params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          first_name: ''
        }
      end

      it 'returns an error' do
        put api_user_path(user), params: params

        expect(response_hash).to eq(
          {
            errors: [
              'First name can\'t be blank'
            ]
          }
        )
      end
    end
  end
end
