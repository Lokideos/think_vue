# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTokenSessions::CreateService do
  let(:email) { 'valid_email@example.com' }
  let(:password) { 'valid_password' }

  subject { described_class }

  context 'with valid parameters' do
    let!(:user) { create(:user, email: email, password: password) }

    it 'creates new user token session' do
      expect { subject.call(email, password) }.to change(UserTokenSession, :count).by(1)
    end

    it 'assigns session to result' do
      result = subject.call(email, password)

      expect(result.session).to be_kind_of(UserTokenSession)
    end
  end

  context 'with invalid parameters' do
    context 'user does not exist' do
      it 'should not create session' do
        expect { subject.call(email, password) }.to_not change(UserTokenSession, :count)
      end

      it 'should return fail result' do
        result = subject.call(email, password)

        expect(result).to be_failure
      end

      it 'should add an error' do
        result = subject.call(email, password)

        expect(result.errors)
          .to include(I18n.t(:unauthorized, scope: 'services.user_token_sessions.create_service'))
      end
    end

    context 'provided with invalid password' do
      let(:bad_password) { 'bad_password' }
      let!(:user) { create(:user, email: email, password: password) }

      it 'should not create session' do
        expect { subject.call(email, bad_password) }.to_not change(UserTokenSession, :count)
      end

      it 'should return fail result' do
        result = subject.call(email, bad_password)

        expect(result).to be_failure
      end

      it 'should add an error' do
        result = subject.call(email, bad_password)

        expect(result.errors)
          .to include(I18n.t(:unauthorized, scope: 'services.user_token_sessions.create_service'))
      end
    end
  end
end
