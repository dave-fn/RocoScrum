class Api::V1::TeamsController < Api::V1::ControllerBase

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user

end
