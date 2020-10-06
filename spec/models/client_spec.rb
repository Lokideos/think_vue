# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should validate_presence_of :phone }
  it { should validate_presence_of :fullname }
end
