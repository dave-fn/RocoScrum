# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::ControllerBase

  before_action :authenticate_user

end
