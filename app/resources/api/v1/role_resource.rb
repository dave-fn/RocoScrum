class Api::V1::RoleResource < JSONAPI::Resource

  immutable

  attributes :name, :description, :min_participants, :max_participants
  
  # Hide ID
  def id
    @model.hashid
  end

  # filter :id, verify: :verify_keys, apply: -> (records, value, options) do
  #   return [] if records.size == 0
  #   value = records[0].class.decode_id(value) if value.is_a? String
  #   records.where(id: value)
  # end

end
