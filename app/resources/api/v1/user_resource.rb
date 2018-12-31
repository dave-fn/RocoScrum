class Api::V1::UserResource < JSONAPI::Resource

  # Preliminary Implementation
  immutable

  key_type :string

  attributes :name, :email, :last_logged_at
  
  filter :email
  filter :id, verify: :verify_keys,
    apply: -> (records, value, options) do
      value = options.dig(:context, :backing_model).decode_id(value)
      records.where(id: value)
    end

  # Hide ID
  def id
    @model.hashid
  end

end
