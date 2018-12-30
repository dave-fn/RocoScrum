class Api::V1::RolesController < JSONAPI::ResourceController

  def context
    {backing_model: Role}
  end

end
