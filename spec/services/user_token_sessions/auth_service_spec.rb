# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTokenSessions::AuthService do
  subject { described_class }

  context 'with valid parameters' do
    let!(:user) { create(:user) }
    let!(:user_session) { create(:user_token_session, user: user) }

    it 'should return result with User instance' do
      result = subject.call(user_session.uuid)

      expect(result.user).to be_kind_of(User)
    end

    it 'should return result with correct user' do
      result = subject.call(user_session.uuid)

      expect(result.user).to eq user
    end

    it 'should not return any errors' do
      result = subject.call(user_session.uuid)

      expect(result.errors).to be_empty
    end
  end

  context 'with invalid parameters' do
    let!(:user) { create(:user) }

    context 'session with given uuid does not exist' do
      let(:bad_uuid) { 'bad_uuid' }

      it 'should not return any user' do
        result = subject.call(bad_uuid)

        expect(result.user).to be_nil
      end

      it 'should return non-empty errors array in result' do
        result = subject.call(bad_uuid)

        expect(result.errors).to_not be_empty
      end

      it 'should add an unauthorized error' do
        result = subject.call(bad_uuid)

        expect(result.errors)
          .to include(I18n.t(:unauthorized, scope: 'services.user_token_sessions.auth_service'))
      end
    end

    context 'session with given uuid is expired' do
      let!(:user_session) do
        create(:user_token_session,
               user: user,
               created_at: Time.now - UserTokenSession::TOKEN_EXPIRATION - 1)
      end

      it 'should not return any user' do
        result = subject.call(user_session.uuid)

        expect(result.user).to be_nil
      end

      it 'should return non-empty errors array in result' do
        result = subject.call(user_session.uuid)

        expect(result.errors).to_not be_empty
      end

      it 'should add an token_expired error' do
        result = subject.call(user_session.uuid)

        expect(result.errors)
          .to include(I18n.t(:token_expired, scope: 'services.user_token_sessions.auth_service'))
      end
    end
  end
end
