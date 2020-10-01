# frozen_string_literal: true

class Staff::StaffsController < Staff::BaseController
  def index; end

  def user_data
    serializer = UserSerializer.new(current_user)

    render json: serializer.serializable_hash, status: :ok
  end
end
