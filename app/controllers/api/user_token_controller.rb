# frozen_string_literal: true

class Api::UserTokenController < Knock::AuthTokenController

  skip_before_action :verify_authenticity_token

  before_action :set_content_type
  before_action :update_user_logged_timestamp, only: [:create] # rubocop:disable Rails/LexicallyScopedActionFilter

  rescue_from Knock.not_found_exception_class, with: :four_oh_four


  private

  def update_user_logged_timestamp
    entity.update!(last_logged_at: Time.now.utc)
  end

  def set_content_type
    self.content_type = Mime[:api_json]
  end

  def four_oh_four(_exception)
    render json: { error: 'Unable to verify credentials' }, status: :not_found
  end

end
