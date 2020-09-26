# frozen_string_literal: true

module UserTokenSessions
  class AuthService
    prepend BasicService

    attr_reader :user

    def initialize(uuid)
      @uuid = uuid
      @session = UserTokenSession.find_by(uuid: @uuid)
    end

    def call
      validate
      return if failure?

      @user = @session.user
    end

    private

    def validate
      return fail_t!(:unauthorized) unless @session.present?

      fail_t!(:token_expired) if @session.token_expired?
    end

    def fail_t!(key)
      fail!(I18n.t(key, scope: 'services.user_token_sessions.auth_service'))
    end
  end
end
