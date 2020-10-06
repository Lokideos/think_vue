# frozen_string_literal: true

class Client < User
  validates :fullname, :phone, presence: true
end
