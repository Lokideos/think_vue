# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTokenSession, type: :model do
  it { should validate_presence_of :uuid }

  context 'uniqueness validations' do
    before { create(:user_token_session) }

    it { should validate_uniqueness_of :uuid }
  end
end
