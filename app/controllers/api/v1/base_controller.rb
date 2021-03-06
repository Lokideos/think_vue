# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
end
