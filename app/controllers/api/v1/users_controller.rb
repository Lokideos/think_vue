# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def token_login
    result = UserTokenSessions::CreateService.call(*token_login_params.values)

    if result.success?
      token = { token: JwtEncoder.encode(uuid: result.session.uuid) }
      render json: { meta: token }, status: :created
    else
      render json: {}, status: :unauthorized
    end
  end

  private

  def token_login_params
    params.require(:user).permit(:email, :password)
  end
end
