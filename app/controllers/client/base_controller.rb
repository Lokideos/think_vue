class Client::BaseController < ApplicationController
  before_action :authenticate_user!
end
