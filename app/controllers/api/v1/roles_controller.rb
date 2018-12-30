class Api::V1::RolesController < JSONAPI::ResourceController

  before_action :decode_hash_id, only: [:show]
  

  private

  def decode_hash_id
    decode_hash_id_of_model Role
  end

  def decode_hash_id_of_model(model_class)
    params[:id] = model_class.decode_id(params[:id])
  end

end
