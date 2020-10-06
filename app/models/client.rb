# frozen_string_literal: true

class Client < User
  validates :fullname, :phone, presence: true

  def self.validate_param(params)
    validation_type = params.keys.first
    case validation_type
    when 'email' then validate_email_uniqueness(params['email'])
    when 'phone' then validate_phone_uniqueness(params['phone'])
    else
      false
    end
  end

  def self.validate_email_uniqueness(email)
    !Client.exists?(email: email)
  end

  def self.validate_phone_uniqueness(phone)
    !Client.exists?(phone: phone)
  end
end
