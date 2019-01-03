class Api::V1::ResourceBase < JSONAPI::Resource

  abstract

  def self.hide_id(with:, restore:, type: :integer)
    self.key_type type
    define_method(:id) { @model.send(with) }
    filter :id, verify: :verify_keys,
      apply: -> (records, value, options) do
        records.where id: restore.call(value)
      end
  end

  def self.hide_id_with_hash_id
    hide_id with: :hashid, type: :string, restore: -> value { _model_class.decode_id value }
  end

end
