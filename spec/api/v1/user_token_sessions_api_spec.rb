# frozen_string_literal: true

require 'rails_helper'

describe 'User Token Sessions API' do
  let(:headers) do
    { 'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json' }
  end

  describe 'POST /api/v1/users/token_login' do
    let(:api_path) { '/api/v1/users/token_login' }
    let(:user) { create(:user) }

    context 'with valid params' do
      let(:body) do
        {
          user: {
            email: user.email,
            password: user.password
          }
        }.to_json
      end

      context 'UserSession for this user does not exist' do
        it 'should create new UserTokenSession' do
          expect { post(api_path, params: body, headers: headers) }
            .to change(UserTokenSession, :count).by(1)
        end

        it 'should return 201 Created status' do
          post(api_path, params: body, headers: headers)

          expect(response).to have_http_status :created
        end

        it 'should return correct token' do
          post(api_path, params: body, headers: headers)

          created_session_uuid = user.user_token_sessions.first.uuid
          decoded_uuid = JwtEncoder.decode(JSON(response.body).dig('meta', 'token'))['uuid']

          expect(decoded_uuid).to eq created_session_uuid
        end
      end

      context 'UserSession for this user exists' do
        let!(:user_session_token) { create(:user_token_session, user: user) }

        it 'should not create new UserTokenSession' do
          expect { post(api_path, params: body, headers: headers) }
            .to_not change(UserTokenSession, :count)
        end

        it 'should return 201 Created status' do
          post(api_path, params: body, headers: headers)

          expect(response).to have_http_status :created
        end

        it 'should return correct token' do
          post(api_path, params: body, headers: headers)

          created_session_uuid = user_session_token.uuid
          decoded_uuid = JwtEncoder.decode(JSON(response.body).dig('meta', 'token'))['uuid']

          expect(decoded_uuid).to eq created_session_uuid
        end
      end
    end

    context 'with invalid params' do
      let(:body) do
        {
          user: {
            email: user.email,
            password: 'bad password'
          }
        }.to_json
      end

      it 'should not create new UserTokenSession' do
        expect { post(api_path, params: body, headers: headers) }
          .to_not change(UserTokenSession, :count)
      end

      it 'should return 401 Unauthorized status' do
        post(api_path, params: body, headers: headers)

        expect(response).to have_http_status :unauthorized
      end

      it 'should return empty json' do
        post(api_path, params: body, headers: headers)

        expect(response.body).to eq '{}'
      end
    end
  end
end
