FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-email#{n}@example.com" }
    sequence(:password) { |n| "password#{n}" }
  end
end
