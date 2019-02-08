class Api::V1::ControllerBase < JSONAPI::ResourceController

  include Knock::Authenticable
  
  before_action :set_content_type

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  private

  def context
    {user: current_user}
  end

  def user_not_authorized
    head :forbidden
  end

  def set_content_type
    self.content_type = Mime[:api_json]
  end
  
end
