class Api::V1::ResourceBase < JSONAPI::Resource

  abstract

  def self.key_by_hashid
    key_type :string

    filter :id,
      verify: :verify_keys,
      apply: -> (records, value, options) do
        records.where(id: value)
      end

    def self.find_by_key(key, options = {})
      begin
        model = _model_class.find(key)
      rescue ActiveRecord::RecordNotFound
        fail JSONAPI::Exceptions::RecordNotFound.new(key)
      end
      self.resource_for_model(model).new(model, options[:context])
    end

    def self.verify_key(key, context = nil)
      _model_class.decode_id(key)
    end

    def default_hashid
      ''
    end

    def id
      return default_hashid if @model.id == nil
      @model.hashid
    end
  end

end
