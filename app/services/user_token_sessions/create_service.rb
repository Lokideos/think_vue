# frozen_string_literal: true

module UserTokenSessions
  class CreateService
    prepend BasicService

    attr_reader :session

    def initialize(email, password)
      @email = email
      @password = password
      @user = User.find_by(email: @email)
    end

    def call
      return fail_t!(:unauthorized) unless @user&.valid_password?(@password)

      create_session
    end

    private

    def create_session
      @session = UserTokenSession.find_by(user: @user)
      @session = @session.present? ? reinitialized_session : new_session_for_user(@user)

      @session.valid? ? @session.save : fail!(@session.errors)
    end

    def reinitialized_session
      @session.destroy
      new_session_for_user(@user)
    end

    def new_session_for_user(user)
      user.user_token_sessions.new(uuid: SecureRandom.uuid)
    end

    def fail_t!(key)
      fail!(I18n.t(key, scope: 'services.user_token_sessions.create_service'))
    end
  end
end
