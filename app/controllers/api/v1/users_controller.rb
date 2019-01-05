class Api::V1::UsersController < JSONAPI::ResourceController

  include Knock::Authenticable
  before_action :authenticate_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  private

  def context
    {user: current_user}
  end

  def user_not_authorized
    head :forbidden
  end
  
end
