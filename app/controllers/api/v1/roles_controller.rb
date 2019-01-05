class Api::V1::RolesController < JSONAPI::ResourceController
  
  include Knock::Authenticable
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  private

  def context
    {user: current_user}
  end

  def user_not_authorized
    head :forbidden
  end

end
