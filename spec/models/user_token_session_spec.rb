# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTokenSession, type: :model do
  it { should validate_presence_of :uuid }

  context 'uniqueness validations' do
    before { create(:user_token_session) }

    it { should validate_uniqueness_of :uuid }
  end

  describe '#token_expired?' do
    context 'session was created less then 2 hours ago' do
      let(:user_token_session) { create(:user_token_session) }

      it 'should return false' do
        expect(user_token_session).to_not be_token_expired
      end
    end

    context 'session was created more then 2 hours ago' do
      let(:user_token_session) { create(:user_token_session, created_at: Time.now - 2.hours - 1) }

      it 'should return true' do
        expect(user_token_session).to be_token_expired
      end
    end
  end
end
