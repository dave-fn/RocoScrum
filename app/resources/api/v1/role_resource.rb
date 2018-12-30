class Api::V1::RoleResource < JSONAPI::Resource

  immutable

  key_type :string

  attributes :name, :description, :min_participants, :max_participants
  
  filter :name
  filter :id, verify: :verify_keys,
    # verify: -> (values, context) do
    #   values.map { |value| context[:backing_model].decode_id(value) }
    # end,
    apply: -> (records, value, options) do
      value = options.dig(:context, :backing_model).decode_id(value)
      records.where(id: value)
    end

  # Hide ID
  def id
    @model.hashid
  end

end
