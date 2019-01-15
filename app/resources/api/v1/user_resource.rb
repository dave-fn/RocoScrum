class Api::V1::UserResource < Api::V1::ResourceBase

  include JSONAPI::Authorization::PunditScopedResource
  
  # hide_id_with_hash_id
  
  # Preliminary Implementation
  immutable

  attributes :name, :email, :last_logged_at, :admin?
  
  filter :email

  key_type :string

  def self.find_by_key(key, options = {})
    # puts "find_by_key, key=#{key}, opts=#{options}"
    context = options[:context]
    begin
      model = _model_class.find(key)
    rescue ActiveRecord::RecordNotFound
      fail JSONAPI::Exceptions::RecordNotFound.new(key)
    end
    self.resource_for_model(model).new(model, context)
  end

  def self.verify_key(key, context = nil)
    # puts "verify_key, key=#{key}, context=#{context}"
    # x = super
    # puts "result = #{x}, but could be=#{_model_class.decode_id(key)}"
    # x
    # puts "result = #{_model_class.decode_id key}"
    _model_class.decode_id key
  end

  filter :id,
    verify: :verify_keys,
    apply: -> (records, value, options) do
      # puts "verify :id, value=#{value}"
      # records.where(id: _model_class.decode_id(value))
      records.where(id: value)
    end

  def id
    @model.hashid
  end

end
