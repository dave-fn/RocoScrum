# frozen_string_literal: true

class Api::V1::ProjectsController < Api::V1::ControllerBase

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user

end
