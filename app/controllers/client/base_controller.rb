# frozen_string_literal: true

class Client::BaseController < ApplicationController
  layout 'clients'

  before_action :authenticate_user!
end
