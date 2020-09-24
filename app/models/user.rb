# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_token_sessions

  USER_TYPES = %w[Staff Client].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
