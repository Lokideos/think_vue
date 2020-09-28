# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'uniqueness validations' do
    before { create(:user) }

    it { should validate_uniqueness_of :phone }
  end
end
