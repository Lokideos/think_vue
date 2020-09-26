class Staff::StaffsController < Staff::BaseController
  before_action :load_vue_pack

  def index; end

  private

  def load_vue_pack
    @vue_pack = 'staffs'
  end
end
