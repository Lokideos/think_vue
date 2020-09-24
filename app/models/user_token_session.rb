# frozen_string_literal: true

class UserTokenSession < ApplicationRecord
  TOKEN_EXPIRATION = 7_200

  belongs_to :user

  validates :uuid, presence: true, uniqueness: true
end
