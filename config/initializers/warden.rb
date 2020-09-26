Warden::Strategies.add(:auth_token_strategy) do
  AUTH_TOKEN = /\ABearer (?<token>.+)\z/.freeze

  def extracted_token
    JwtEncoder.decode(matched_token)
  rescue JWT::DecodeError
    {}
  end

  def matched_token
    result = request.headers['Authorization']&.match(AUTH_TOKEN)
    return if result.blank?

    result[:token]
  end

  def valid?
    request.headers['Authorization'].present?
  end

  def authenticate!
    result = UserTokenSessions::AuthService.call(extracted_token['uuid'])

    if result.success?
      success!(result.user)
    else
      fail!(result.errors)
    end
  end
end
