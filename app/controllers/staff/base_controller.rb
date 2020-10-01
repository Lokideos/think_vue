# frozen_string_literal: true

class Staff::BaseController < ApplicationController
  layout 'staffs'

  before_action :authenticate_user!
end
