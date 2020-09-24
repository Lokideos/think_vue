# frozen_string_literal: true

FactoryBot.define do
  factory :user_token_session do
    sequence(:uuid) { |n| "uuid#{n}" }
    user
  end
end
