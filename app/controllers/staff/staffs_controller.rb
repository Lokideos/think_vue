# frozen_string_literal: true

class Staff::StaffsController < Staff::BaseController
  before_action :load_vue_pack

  def index; end

  def user_data
    serializer = UserSerializer.new(current_user)

    render json: serializer.serializable_hash, status: :ok
  end

  private

  def load_vue_pack
    @vue_pack = 'staffs'
  end
end
