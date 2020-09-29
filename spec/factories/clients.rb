# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:email) { |n| "test-email#{n}@example.com" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:fullname) { |n| "fullname#{n}" }
    sequence(:phone) { |n| "phone#{n}" }
  end
end
