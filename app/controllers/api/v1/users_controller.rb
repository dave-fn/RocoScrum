class Api::V1::UsersController < JSONAPI::ResourceController

  include Knock::Authenticable
  before_action :authenticate_user

end
